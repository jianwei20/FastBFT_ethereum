package bft

import (
	"bytes"
	"crypto/ecdsa"
	"errors"
	"fmt"
	"math"
	"sync"
	"time"

	"github.com/ethereum/go-ethereum/common"
	btypes "github.com/ethereum/go-ethereum/consensus/bft/types"
	"github.com/ethereum/go-ethereum/core"
	"github.com/ethereum/go-ethereum/core/types"
	"github.com/ethereum/go-ethereum/crypto"
	"github.com/ethereum/go-ethereum/ethdb"
	"github.com/ethereum/go-ethereum/event"
	"github.com/ethereum/go-ethereum/log"
	"github.com/ethereum/go-ethereum/rlp"
)

type ConsensusContract struct {
	eventMux   *event.TypeMux
	coinbase   common.Address
	txpool     *core.TxPool
	validators []common.Address
}

func NewConsensusContract(eventMux *event.TypeMux, coinbase common.Address, txpool *core.TxPool, validators []common.Address) *ConsensusContract {
	return &ConsensusContract{
		eventMux:   eventMux,
		txpool:     txpool,
		coinbase:   coinbase,
		validators: validators,
	}
}

func chosen(h uint64, r uint64, length int) int {
	sum := h - r
	return int(math.Abs(float64(sum))) % length
}

func (cc *ConsensusContract) proposer(height uint64, round uint64) common.Address {
	addr := cc.validators[chosen(height, round, len(cc.validators))]
	return addr
}

func (cc *ConsensusContract) msigProposers(height uint64, round uint64) []common.Address {
	msigNum := (int((len(cc.validators) - 1) / 3)) // numbers of msig proposer, i.e., f (does not include proposer)
	msigProposers := make([]common.Address, msigNum)
	proposerIndex := chosen(height, round, len(cc.validators))
	msigProposers[0] = cc.validators[(proposerIndex+1)%4]
	return msigProposers
}

func (cc *ConsensusContract) isValidators(v common.Address) bool {
	return containsAddress(cc.validators, v)
}

func (cc *ConsensusContract) isProposer(p btypes.Proposal) bool {
	if addr, err := p.From(); err != nil {
		log.Error("invalid sender %v", err)
		return false
	} else {
		return addr == cc.proposer(p.GetHeight(), p.GetRound())
	}

}

func (cc *ConsensusContract) isMsigProposer(p btypes.Proposal, addr common.Address) bool {
	return containsAddress(cc.msigProposers(p.GetHeight(), p.GetRound()), addr)
}

func (cc *ConsensusContract) numEligibleVotes(height uint64) uint64 {
	if height == 0 {
		return 0
	} else {
		return uint64(len(cc.validators))
	}
}

func containsAddress(s []common.Address, e common.Address) bool {
	for _, a := range s {
		if a == e {
			return true
		}
	}
	return false
}

// if equal than return first para
func Max(x, y int) int {
	if x >= y {
		return x
	}
	return y
}

// if equal than return first para
func Min(x, y int) int {
	if x <= y {
		return x
	}
	return y
}

type StrategyConfig struct {
	DifferentProposal bool
	AlwaysVote        bool
	AlwaysAgree       bool
	NoResponse        bool
}

type ConsensusManager struct {
	pm                      *ProtocolManager
	isAllowEmptyBlocks      bool
	numInitialBlocks        uint64
	roundTimeout            uint64
	roundTimeoutFactor      float64
	transactionTimeout      float64
	chain                   *core.BlockChain
	coinbase                common.Address
	readyValidators         map[common.Address]struct{}
	privkey                 *ecdsa.PrivateKey
	contract                *ConsensusContract
	trackedProtocolFailures []string
	heights                 map[uint64]*HeightManager
	proposalLock            *types.Block
	readyNonce              uint64
	blockCandidates         map[common.Hash]btypes.Proposal
	hdcDb                   ethdb.Database
	synchronizer            *Synchronizer

	currentBlock *types.Block
	found        chan *types.Block

	mu          sync.Mutex
	currentMu   sync.Mutex
	uncleMu     sync.Mutex
	writeMapMu  sync.RWMutex
	getHeightMu sync.RWMutex

	processMu sync.Mutex

	Enable bool
	Config StrategyConfig
}

func NewConsensusManager(manager *ProtocolManager, chain *core.BlockChain, db ethdb.Database, cc *ConsensusContract, privkeyhex string) *ConsensusManager {

	privkey, _ := crypto.HexToECDSA(privkeyhex)
	cm := &ConsensusManager{
		pm:                 manager,
		isAllowEmptyBlocks: false,
		numInitialBlocks:   10,
		roundTimeout:       5,
		roundTimeoutFactor: 1.5,
		transactionTimeout: 0.5,
		hdcDb:              db,
		chain:              chain,
		privkey:            privkey,
		readyValidators:    make(map[common.Address]struct{}),
		heights:            make(map[uint64]*HeightManager),
		readyNonce:         0,
		blockCandidates:    make(map[common.Hash]btypes.Proposal),
		contract:           cc,
		coinbase:           cc.coinbase,
		Enable:             true,
		getHeightMu:        sync.RWMutex{},
	}

	cm.initializeLocksets()

	// old votes don't count
	cm.readyValidators = make(map[common.Address]struct{})
	cm.readyValidators[cm.coinbase] = struct{}{}

	cm.synchronizer = NewSynchronizer(cm)
	return cm
}

// properties
func (cm *ConsensusManager) Head() *types.Block {
	return cm.chain.CurrentBlock()
}

func (cm *ConsensusManager) Now() int64 {
	return time.Now().Unix()
}

func (cm *ConsensusManager) Height() uint64 {
	h := cm.chain.CurrentBlock().NumberU64()
	return h + 1
}

func (cm *ConsensusManager) Round() uint64 {
	return cm.getHeightManager(cm.Height()).Round()
}

func (cm *ConsensusManager) getHeightManager(h uint64) *HeightManager {
	if _, ok := cm.heights[h]; !ok {
		cm.heights[h] = NewHeightManager(cm, h)
	}
	return cm.heights[h]
}

func (cm *ConsensusManager) activeRound() *RoundManager {
	hm := cm.getHeightManager(cm.Height())
	rm := hm.getRoundManager(hm.Round())
	return rm
}

func (cm *ConsensusManager) enable() {
	cm.Enable = true
}

func (cm *ConsensusManager) disable() {
	cm.Enable = false
}

func (cm *ConsensusManager) setByzantineMode(mode int) {
	switch mode {
	case 0:
		cm.Config = StrategyConfig{false, false, false, false}
	case 1:
		cm.Config = StrategyConfig{true, false, false, false}
	case 2:
		cm.Config = StrategyConfig{false, true, false, false}
	case 3:
		cm.Config = StrategyConfig{false, false, true, false}
	case 4:
		cm.Config = StrategyConfig{false, false, false, true}
	case 5:
		cm.Config = StrategyConfig{true, true, true, false}
	default:
		cm.Config = StrategyConfig{false, false, false, false}
	}
}

func (cm *ConsensusManager) initializeLocksets() {
	// initializing locksets
	// sign genesis
	log.Debug("initialize locksets")
	v := btypes.NewVote(0, 0, cm.chain.Genesis().Hash(), 1) // voteBlock

	cm.Sign(v)
	cm.AddVote(v)
	// add initial lockset
	log.Debug("inintial lockset")
	lastCommittingLockset := cm.loadLastCommittingLockset()
	if lastCommittingLockset != nil {
		_, hash := lastCommittingLockset.HasQuorum()
		if hash != cm.Head().Hash() {
			log.Error("initialize_locksets error: hash not match")
			return
		}
		for _, v := range lastCommittingLockset.Votes {
			cm.AddVote(v)
		}
	}
}

// persist proposals and last committing lockset
func (cm *ConsensusManager) storeLastCommittingLockset(ls *btypes.LockSet) error {
	bytes, err := rlp.EncodeToBytes(ls)
	if err != nil {
		return err
	}
	if err := cm.hdcDb.Put([]byte("last_committing_lockset"), bytes); err != nil {
		log.Error("failed to store last committing lockset into database", "err", err)
		return err
	}
	return nil
}

func (cm *ConsensusManager) loadLastCommittingLockset() *btypes.LockSet {
	key := fmt.Sprintf("last_committing_lockset")
	data, _ := cm.hdcDb.Get([]byte(key))
	if len(data) == 0 {
		return nil
	}
	var lockset *btypes.LockSet
	if err := rlp.Decode(bytes.NewReader(data), &lockset); err != nil {
		log.Error("invalid last_committing_lockset ", "err:", err)
		return nil
	}
	return lockset
}

func (cm *ConsensusManager) storeLockset(blockhash common.Hash, ls *btypes.LockSet) error {
	log.Info("---storeLockset---")
	bytes, err := rlp.EncodeToBytes(ls)
	if err != nil {
		panic(err)
	}
	key := fmt.Sprintf("Lockset:%s", blockhash)
	if err := cm.hdcDb.Put([]byte(key), bytes); err != nil {
		log.Error("failed to store proposal into database", "err", err)
		return err
	}
	return nil
}

func (cm *ConsensusManager) loadLockset(blockhash common.Hash) *btypes.LockSet {
	key := fmt.Sprintf("Lockset:%s", blockhash)
	data, _ := cm.hdcDb.Get([]byte(key))
	if len(data) == 0 {
		return nil
	}
	var ls *btypes.LockSet
	if err := rlp.Decode(bytes.NewReader(data), &ls); err != nil {
		log.Error("invalid Lockset RLP for hash", "blockhash", blockhash, "err", err)
		return nil
	}
	return ls
}

func (cm *ConsensusManager) getLocksetByHeight(height uint64) *btypes.LockSet {
	if height >= cm.Height() {
		log.Error("getLocksetByHeight error")
		return nil
	} else {
		bh := cm.chain.GetBlockByNumber(uint64(height)).Hash()
		return cm.loadLockset(bh)
	}
}

func (cm *ConsensusManager) setupTimeout(h uint64) {
	cm.getHeightMu.Lock()
	ar := cm.activeRound()
	if cm.isWaitingForProposal() {
		delay := ar.getTimeout()
		// if timeout is setup already, skip
		if delay > 0 {
			log.Debug("delay time :", "delay", delay)
		}
	}
	cm.getHeightMu.Unlock()

}

func (cm *ConsensusManager) isWaitingForProposal() bool {
	return cm.isAllowEmptyBlocks || cm.hasPendingTransactions() || cm.Height() <= cm.numInitialBlocks
}

func (cm *ConsensusManager) hasPendingTransactions() bool {
	if txs, err := cm.pm.txpool.Pending(); err != nil {
		log.Debug("error occur")
		panic(err)
	} else {
		return len(txs) > 0
	}
}

func (cm *ConsensusManager) Process(block *types.Block, abort chan struct{}, found chan *types.Block) {
	log.Info("Start Process")
	if !cm.contract.isValidators(cm.coinbase) {
		log.Debug("Node is Not a Validator")
		return
	}
	log.Info("in cm.Process, check lastCommittingLockset()")
	if ls := cm.lastCommittingLockset(); ls != nil {
		cm.storeLastCommittingLockset(ls)
	}
	if cm.currentBlock == nil {
		cm.currentBlock = block
	} else if cm.currentBlock.NumberU64() != block.NumberU64() {
		cm.currentBlock = block
	}

	cm.found = found
	cm.enable()
	if cm.Height() != block.Number().Uint64() || !cm.Enable {
		return
	}

	fmt.Println("=====CM.COINBASE IS:=====", cm.coinbase, "block number is:", block.NumberU64())

	log.Debug("Start Loop")
	for cm.Enable {
		select {
		case <-abort:
			log.Info("case: abord")
			// cm.currentBlock = nil
			// cm.found = nil
			return
		default:
			log.Info("case: default, cm.process")
			cm.process()
			log.Info("after cm.process()")
			time.Sleep(100 * time.Millisecond)
		}
	}
}

func (cm *ConsensusManager) process() {
	if !cm.isReady() {
		log.Info("---------------not ready------------------")
		// cm.setupAlarm(h)
		return
	} else {
		log.Info("---------------process------------------")
		cm.setupTimeout(cm.Height())
		cm.getHeightMu.Lock()
		heightManager := cm.getHeightManager(cm.Height())
		log.Debug("hm process")
		heightManager.process()
		cm.getHeightMu.Unlock()
		cm.cleanup()
	}
}

func (cm *ConsensusManager) validatorCommit(p *peer, block *types.Block) {
	var start = time.Now()
	fmt.Println("cmH", cm.Height())
	if cm.coinbase != block.Header().Coinbase && cm.Height() >= 1 {
		log.Info("in validatorCommit1")
		fmt.Println("pid:", p.id)
		fmt.Println("block number", block.NumberU64())
		result, err := types.NewBFTValidatorBlock(block, p.id)
		log.Info("in validatorCommit2")
		if err != nil {
			log.Info("create BFTValidatorBlock error")
			return
		}
		result.PeerId = p.id
		result.Block = block
		cm.pm.bftValidatorCommitCh <- result
		fmt.Println("validatorCommit time:", time.Since(start))
	} else {
		log.Info("self.Proposer==True")
	}
}

func (cm *ConsensusManager) commitLockset(hash common.Hash, ls *btypes.LockSet, peer *peer) {
	cm.writeMapMu.Lock()
	defer cm.writeMapMu.Unlock()
	log.Info("============in cm.commitLockset============")
	proposal, ok := cm.blockCandidates[hash]

	if ok {
		if proposal.GetBlock().ParentHash() != cm.Head().Hash() {
			log.Debug("wrong parent hash: ", proposal.GetBlock().ParentHash(), cm.Head().Hash())
			return
		}
		if ls != nil {
			log.Info("in commitLockset, check ls HasQuorum")
			_, hash := ls.HasQuorum()
			if proposal.Blockhash() == hash {
				if cm.found != nil {
					log.Info("cm.found is not nil")
					select {
					case cm.found <- proposal.GetBlock():
						log.Info("store lockset")
						if cm.coinbase != proposal.GetBlock().Header().Coinbase && cm.Height() >= 1 {
							fmt.Println("peerid:", peer.id)
							go cm.validatorCommit(peer, proposal.GetBlock())
						}
						cm.storeLockset(hash, ls)
						cm.disable()
					default:
						log.Info("proposal.GetBlock() failed")
					}
				} else {
					log.Info("cm.found is nil")
				}
				return
			}
		}
	} else {
		log.Info("blockCandidate is nil")
		if ls != nil {
			result, hash := ls.HasQuorum()
			if result {
				log.Info("store lockset")
				cm.storeLockset(hash, ls)
			}
		}
	}
	log.Info("=============leave cm.commitLockset================")
}

func (cm *ConsensusManager) verifyVotes(header *types.Header) error {
	log.Info("In verifyVotes")
	number := header.Number.Uint64()
	blockhash := header.Hash()

	if ls := cm.loadLockset(blockhash); ls != nil {
		_, hash := ls.HasQuorum()
		if blockhash == hash {
			return nil
		} else {
			log.Error("verify Votes Error Occur")
			return errors.New("store Lockset hash is not the same")
		}
	} else {
		log.Debug("verify Votes Failed, sync with others")
		cm.synchronizer.request(cm.Height(), number)
		time.Sleep(200 * time.Millisecond) // wait for request from others
		return cm.verifyVotes(header)
	}
}

func (cm *ConsensusManager) cleanup() {
	log.Debug("in cleanup,current Head Number is ", "number", cm.Head().Header().Number.Uint64())
	cm.writeMapMu.Lock()
	for hash, p := range cm.blockCandidates {
		if cm.Head().Header().Number.Uint64() >= p.GetHeight() {
			delete(cm.blockCandidates, hash)
		}
	}
	cm.writeMapMu.Unlock()
	cm.getHeightMu.Lock()
	for i, _ := range cm.heights {
		if cm.getHeightManager(i).height < cm.Head().Header().Number.Uint64() {
			////DEBUG
			log.Debug("Delete BlockCandidte", i)
			delete(cm.heights, i)
		}
	}
	cm.getHeightMu.Unlock()
}

func (cm *ConsensusManager) Sign(s interface{}) {
	log.Debug("CM Sign")
	switch t := s.(type) {
	case *btypes.BlockProposal:
		t.Sign(cm.privkey)
	case *btypes.Vote:
		t.Sign(cm.privkey)
	case *btypes.LockSet:
		t.Sign(cm.privkey)
	case *btypes.VotingInstruction:
		t.Sign(cm.privkey)
	case *btypes.Ready:
		t.Sign(cm.privkey)
	case *btypes.SyncLockset:
		t.Sign(cm.privkey)
	case *btypes.MsigProposal:
		t.Sign(cm.privkey)
	default:
		log.Debug("consensus mangaer sign error")
	}
}

func (cm *ConsensusManager) setProposalLock(block *types.Block) {
	// TODO: update this
	cm.proposalLock = block
}

func (cm *ConsensusManager) broadcast(msg interface{}) {
	cm.pm.BroadcastBFTMsg(msg)
}

func (cm *ConsensusManager) isReady() bool {
	fmt.Println("ready:", len(cm.readyValidators), "need:", float32(len(cm.contract.validators))*2.0/3.0)
	return float32(len(cm.readyValidators)) > float32(len(cm.contract.validators))*2.0/3.0
}

func (cm *ConsensusManager) SendReady(force bool) {

	if cm.isReady() && !force {
		return
	}
	ls := cm.activeRound().lockset
	r := btypes.NewReady(cm.readyNonce, ls)
	cm.Sign(r)
	r.From()
	cm.broadcast(r)
	cm.readyNonce += 1
}

func (cm *ConsensusManager) AddReady(ready *btypes.Ready) {
	cc := cm.contract
	addr, err := ready.From()
	fmt.Println("AddReady from:", addr)
	if err != nil {
		log.Error("AddReady err ", "err", err)
		return
	}
	if !cc.isValidators(addr) {
		log.Debug(addr.Hex())
		log.Debug("receive ready from invalid sender")
		return
	}
	if _, ok := cm.readyValidators[addr]; !ok {
		cm.writeMapMu.Lock()
		cm.readyValidators[addr] = struct{}{}
		cm.writeMapMu.Unlock()
	}
}

func (cm *ConsensusManager) AddVote(v *btypes.Vote) bool {
	// vote.blockhash equal blockCandidates.blockhash
	if v == nil {
		log.Debug("cm addvote error")
		return false
	}
	addr, _ := v.From()
	if _, ok := cm.readyValidators[addr]; !ok {
		cm.writeMapMu.Lock()
		cm.readyValidators[addr] = struct{}{}
		cm.writeMapMu.Unlock()
	}
	if v.Height > cm.Height() {
		log.Debug("received v.H > self.H trying to sync lockset")
		cm.synchronizer.request(cm.Height(), v.Height)
	}
	cm.getHeightMu.Lock()
	h := cm.getHeightManager(v.Height)
	success := h.addVote(v)
	log.Info("addVote to ", "height", v.Height, "round", v.Round, "from", addr, "success", success, "cm.coinbase", cm.coinbase)

	cm.getHeightMu.Unlock()
	return success
}

func (cm *ConsensusManager) AddMsigProposal(mp btypes.Proposal, peer *peer) bool {
	// 1. block hasValid sig
	// 2. push block into blockCandidates without msig
	log.Debug("--------------in AddMsigProposal----------------")
	addr, err := mp.From()
	if err != nil {
		log.Debug("msigproposal sender error", "err", err)
		return false
	}
	rm := cm.getHeightManager(cm.Height()).getRoundManager(cm.Round())
	if p := rm.proposal; p != nil {
		if mp.Blockhash() != p.Blockhash() {
			if mp.GetHeight() == p.GetHeight() && mp.GetRound() == p.GetRound() {
				log.Info("mp.Blockhash != p.Blockhash")
				return false
			}
		}
	} else {
		log.Info("received mp before p, wait for a while")
		time.Sleep(100 * time.Millisecond)
		return cm.AddMsigProposal(mp, peer)
	}
	if cm.contract.isMsigProposer(mp, cm.coinbase) {
		err := mp.Msign(cm.privkey, cm.coinbase)
		if err != nil {
			log.Debug("in AddMsigProposal, msig failed")
			return false
		}
		cm.Sign(mp)
		cm.broadcast(mp)
	}
	if _, ok := cm.readyValidators[addr]; !ok {
		cm.writeMapMu.Lock()
		cm.readyValidators[addr] = struct{}{}
		cm.writeMapMu.Unlock()
	}

	if !mp.MsigFinished(cm.contract.msigProposers(mp.GetHeight(), mp.GetRound())) {
		log.Debug("msigProposal have not finished yet")
		return false
	}
	cm.getHeightMu.Lock()
	isValid := cm.getHeightManager(mp.GetHeight()).addMsigProposal(mp)
	if !isValid {
		log.Debug("hm.rm.addMsigProposal failed")
		return false
	}
	//cm.addBlockCandidates(mp)
	cm.getHeightMu.Unlock()
	return isValid
}

func (cm *ConsensusManager) collectMsig(p btypes.Proposal, peer *peer) bool {
	// collect multisignature
	// 1. valid proposal
	// 2. only one proposal
	// 3. add msig
	if p == nil {
		panic("nil peer in cm AddProposal")
	}
	addr, err := p.From()
	if err != nil {
		log.Info("proposal sender error ", "err", err)
		return false
	}
	if !cm.contract.isProposer(p) {
		log.Info("proposal sender invalid", cm.contract.isProposer(p))
		return false
	}
	if _, ok := cm.readyValidators[addr]; !ok {
		cm.writeMapMu.Lock()
		cm.readyValidators[addr] = struct{}{}
		cm.writeMapMu.Unlock()
	}
	ls := p.LockSet()
	if !ls.IsValid() && ls.EligibleVotesNum != 0 {
		log.Info("proposal lockset invalid")
		return false
	}
	switch proposal := p.(type) {
	case *btypes.BlockProposal:
		if !cm.verifyBlockProposal(proposal) {
			return false
		}
	case *btypes.VotingInstruction:
		if !cm.verifyVotingInstruction(proposal) {
			return false
		}
	}
	cm.getHeightMu.Lock()
	isValid := cm.getHeightManager(p.GetHeight()).collectMsig(p)
	if !isValid {
		return false
	}
	if p.GetHeight() > cm.Height() {
		cm.synchronizer.request(cm.Height(), p.GetHeight())
	}
	if cm.contract.isMsigProposer(p, cm.coinbase) {
		log.Info("in collectMsig, i am msig proposer")
		mp, _ := btypes.NewMsigProposal(cm.Height(), cm.Round(), p)
		err := mp.Msign(cm.privkey, cm.coinbase)
		if err != nil {
			log.Info("in collectMsig, msig failed")
			return false
		}
		cm.Sign(mp)
		cm.broadcast(mp)

		fmt.Println("in cm.collectMsig, mp.MsigVs:", mp.Msig.MsigVs)

		isValid := cm.getHeightManager(mp.GetHeight()).addMsigProposal(mp)
		if !isValid {
			log.Debug("hm.rm.addMsigProposal failed")
			return false
		}
	}

	if p.GetBlock() == nil {
		log.Info("In cm.collectMsig, proposal.GetBlock is nil")
	}

	hm := cm.getHeightManager(p.GetHeight())
	rm := hm.getRoundManager(p.GetRound())

	rm.proposerPeer = peer
	cm.addBlockCandidates(p)
	cm.getHeightMu.Unlock()
	return isValid
}

func (cm *ConsensusManager) verifyBlockProposal(bp *btypes.BlockProposal) bool {
	log.Info("cm add BlockProposal", "h", bp.Height, "r", bp.Round)
	result, _ := bp.SigningLockset.HasQuorum()
	slH := bp.SigningLockset.Height()
	if !result || slH != bp.Height-1 {
		log.Info("Error: proposal error")
		return false
	}
	cm.getHeightMu.Lock()
	h := cm.getHeightManager(slH)
	for _, v := range bp.SigningLockset.Votes {
		h.addVote(v)
	}
	cm.getHeightMu.Unlock()
	return true
}

func (cm *ConsensusManager) verifyVotingInstruction(vi *btypes.VotingInstruction) bool {
	log.Info("in cm collectMsig,", "h", vi.Height, "r", vi.Round)
	result, _ := vi.RoundLockset.QuorumPossible()
	if !result {
		log.Info("vi proposal dont have quorum possible")
		return false
	}
	return true
}

func (cm *ConsensusManager) addBlockCandidates(p btypes.Proposal) {
	cm.writeMapMu.Lock()
	hash := p.Blockhash()
	cm.blockCandidates[hash] = p
	log.Info("In addBlockCandidates!!")
	if p.GetBlock() == nil {
		log.Info("In cm.addBlockCandidates, proposal.GetBlock is nil")
	}

	cm.writeMapMu.Unlock()
}

func (cm *ConsensusManager) lastCommittingLockset() *btypes.LockSet {
	log.Debug("In lastCommittingLockset")
	ls := cm.getHeightManager(cm.Height() - 1).lastQuorumLockSet()
	if ls == nil {
		return nil
	}
	return ls
}

func (cm *ConsensusManager) HighestCommittingLockset() *btypes.LockSet {
	var hcls *btypes.LockSet
	hcls = nil
	for i, height := range cm.heights {
		ls := height.lastQuorumLockSet()
		if ls != nil {
			if hcls == nil {
				hcls = ls
			} else if i > hcls.Height() {
				hcls = ls
			}
		}
	}
	return hcls
}

func (cm *ConsensusManager) lastRoundLockset() *btypes.LockSet {
	ls := cm.getHeightManager(cm.Height()).lastRoundLockset()
	return ls
}

func (cm *ConsensusManager) lastLock() *btypes.Vote {
	return cm.getHeightManager(cm.Height()).LastVoteLock()
}

func (cm *ConsensusManager) mkLockSet(height uint64) *btypes.LockSet {
	return btypes.NewLockSet(cm.contract.numEligibleVotes(height), []*btypes.Vote{})
}

type HeightManager struct {
	cm          *ConsensusManager
	height      uint64
	rounds      map[uint64]*RoundManager
	writeMapMu  sync.RWMutex
	activeRound uint64
}

func NewHeightManager(consensusmanager *ConsensusManager, height uint64) *HeightManager {
	return &HeightManager{
		cm:          consensusmanager,
		height:      height,
		rounds:      make(map[uint64]*RoundManager),
		writeMapMu:  sync.RWMutex{},
		activeRound: 0,
	}
}

func (hm *HeightManager) Round() uint64 {
	return hm.activeRound
}

func (hm *HeightManager) getRoundManager(r uint64) *RoundManager {
	hm.writeMapMu.Lock()
	defer hm.writeMapMu.Unlock()
	if _, ok := hm.rounds[r]; !ok {
		//fmt.Println("getRoundManager:", r)
		hm.rounds[r] = NewRoundManager(hm, r)
	}
	return hm.rounds[r]
}

func (hm *HeightManager) LastVoteLock() *btypes.Vote {
	// highest lock
	for i := len(hm.rounds) - 1; i >= 0; i-- {
		index := uint64(i)
		//fmt.Println("6. start lastvotelock", len(hm.rounds), "index:", index)
		if hm.getRoundManager(index).voteLock != nil {
			v := hm.getRoundManager(index).voteLock
			//fmt.Println("6. after lastvotelock", len(hm.rounds), "index:", index)
			return v
		}
	}
	return nil
}

func (hm *HeightManager) LastVotedBlockProposal() *btypes.BlockProposal {
	// the last block proposal node voted on
	for i := len(hm.rounds) - 1; i >= 0; i-- {
		index := uint64(i)
		switch p := hm.getRoundManager(index).proposal.(type) {
		case *btypes.BlockProposal:
			v := hm.getRoundManager(index).voteLock
			if p.Blockhash() == v.Blockhash {
				return p
			}
		default:
			return nil
		}
	}
	return nil
}

func (hm *HeightManager) lastRoundLockset() *btypes.LockSet {
	// last round lockset on height
	fmt.Println("lastRoundLockset, hm.activeround:", hm.activeRound)
	if hm.activeRound == 0 {
		return nil
	}
	r := hm.activeRound - 1
	if !hm.getRoundManager(r).lockset.IsValid() {
		log.Info("lastRoundLockset not valid")
		return nil
	}
	return hm.getRoundManager(r).lockset
}

func (hm *HeightManager) lastQuorumLockSet() *btypes.LockSet {
	log.Debug("in lastQuorumLockSet")
	var found *btypes.LockSet
	for i := 0; i < len(hm.rounds); i++ {
		index := uint64(i)
		ls := hm.getRoundManager(index).lockset
		if ls.IsValid() {
			result, _ := ls.HasQuorum()
			if result {
				found = ls
			}
		}
	}
	log.Debug("return lastQuorumLockSet found")
	return found
}

func (hm *HeightManager) HasQuorum() (bool, common.Hash) {
	ls := hm.lastQuorumLockSet()
	if ls != nil {
		return ls.HasQuorum()
	} else {
		return false, common.Hash{}
	}
}

func (hm *HeightManager) addVote(v *btypes.Vote) bool {
	addr, _ := v.From()
	if !hm.cm.contract.isValidators(addr) {
		log.Debug("non-validator vote")
		return false
	}
	isOwnVote := (addr == hm.cm.contract.coinbase)
	r := v.Round
	addvote_bool := hm.getRoundManager(r).addVote(v, isOwnVote)
	return addvote_bool
}

func (hm *HeightManager) addMsigProposal(p btypes.Proposal) bool {
	rm_bool := hm.getRoundManager(p.GetRound()).addMsigProposal(p)
	return rm_bool
}

func (hm *HeightManager) collectMsig(p btypes.Proposal) bool {
	rm_bool := hm.getRoundManager(p.GetRound()).collectMsig(p)
	return rm_bool
}

func (hm *HeightManager) process() {
	////DEBUG
	r := hm.Round()
	hm.getRoundManager(r).process()
	////DEBUG
}

type RoundManager struct {
	hm               *HeightManager
	cm               *ConsensusManager
	round            uint64
	height           uint64
	lockset          *btypes.LockSet
	proposal         btypes.Proposal
	mProposal        btypes.Proposal
	voteLock         *btypes.Vote
	timeoutTime      float64
	timeoutPrecommit float64
	roundProcessMu   sync.Mutex
	proposerPeer     *peer
}

func NewRoundManager(heightmanager *HeightManager, round uint64) *RoundManager {
	lockset := heightmanager.cm.mkLockSet(heightmanager.height)
	return &RoundManager{
		hm:               heightmanager,
		cm:               heightmanager.cm,
		round:            round,
		height:           heightmanager.height,
		lockset:          lockset,
		timeoutTime:      0,
		timeoutPrecommit: 0,
		proposal:         nil,
		mProposal:        nil,
		voteLock:         nil,
		proposerPeer:     nil,
	}
}

func (rm *RoundManager) getTimeout() float64 {
	if rm.timeoutTime != 0 {
		return 0
	}
	now := rm.cm.Now()
	roundTimeout := rm.cm.roundTimeout
	roundTimeoutFactor := rm.cm.roundTimeoutFactor
	delay := float64(roundTimeout) * math.Pow(roundTimeoutFactor, float64(rm.round))
	rm.timeoutTime = float64(now) + delay
	log.Debug("RM gettimout", "height", rm.height, "round", rm.round)
	return delay
}

func (rm *RoundManager) setTimeoutPrecommit() {
	if rm.timeoutPrecommit != 0 {
		return
	}
	now := rm.cm.Now()
	timeout := 2
	timeoutFactor := 1.5
	delay := float64(timeout) * math.Pow(timeoutFactor, float64(rm.round))
	rm.timeoutPrecommit = float64(now) + delay
	log.Debug("RM get timeoutPrecommit", "height", rm.height, "round", rm.round)
}

func (rm *RoundManager) addVote(vote *btypes.Vote, force_replace bool) bool {
	if !rm.lockset.Contain(vote) {
		err := rm.lockset.Add(vote, force_replace)
		if err != nil {
			log.Error("err: ", "Add vote to lockset error", err)
			return false
		}
		return true
	}
	return false
}

func (rm *RoundManager) addMsigProposal(p btypes.Proposal) bool {
	rm.roundProcessMu.Lock()
	defer rm.roundProcessMu.Unlock()
	log.Debug("addMsigProposal in ", rm.round, p)
	if rm.mProposal == nil {
		rm.mProposal = p
		return true
	} else if rm.mProposal.Blockhash() == p.Blockhash() {
		return true
	} else {
		log.Debug("addMsigProposal Error, second valid msig proposal", rm.mProposal, p)
		return false
	}
}

func (rm *RoundManager) collectMsig(p btypes.Proposal) bool {
	rm.roundProcessMu.Lock()
	defer rm.roundProcessMu.Unlock()

	log.Debug("collectMsig in ", rm.round, p)
	if rm.proposal == nil {
		rm.proposal = p
		return true
	} else if rm.proposal.Blockhash() == p.Blockhash() {
		return true
	} else {
		log.Debug("addProposal Error, received second diff proposal:", rm.proposal, p)
		return false
	}
}

func (rm *RoundManager) process() {
	rm.roundProcessMu.Lock()
	defer rm.roundProcessMu.Unlock()
	log.Info("In RM Process", "height", rm.height, "round", rm.round)
	// Step1 Propose
	p := rm.propose()
	switch proposal := p.(type) {
	case *btypes.BlockProposal:
		rm.cm.broadcast(proposal)
	case *btypes.VotingInstruction:
		rm.cm.broadcast(proposal)
	default:
		log.Debug("propose nothing")
	}

	// Step2 Vote
	if v := rm.vote(); v != nil {
		rm.voteLock = v
		rm.cm.broadcast(v)
	}

	// Step3 Commit
	log.Info("in rm.process, check lockset HasQuorum")
	if result, hash := rm.lockset.HasQuorum(); result {
		log.Info("There is a quorum ", "height", rm.height, "round", rm.round)
		proposer := rm.cm.contract.proposer(rm.height, rm.round)
		if proposer != rm.cm.coinbase && rm.cm.Height() >= 1 {
			fmt.Println("--- in rm.process p.id: ---", rm.proposerPeer)
		}
		rm.cm.commitLockset(hash, rm.lockset, rm.proposerPeer)
	} else {
		log.Info("rm lockset is not valid yet")
	}

	// wait no more vote if timeout reached
	if rm.timeoutTime != 0 && float64(rm.cm.Now()) >= rm.timeoutTime {
		rm.hm.activeRound += 1
	}
}

func (rm *RoundManager) propose() btypes.Proposal {
	log.Info("--------In rm.propose-------")
	var proposal btypes.Proposal
	var block *types.Block
	proposer := rm.cm.contract.proposer(rm.height, rm.round)
	if !rm.cm.isWaitingForProposal() {
		log.Debug("proposing is not waiting for proposal")
		return nil
	}
	if proposer != rm.cm.coinbase {
		log.Debug("I am not proposer in", "height", rm.height, "round", rm.round)
		return nil
	}
	log.Info("I am a proposer in ", "height", rm.height, "round", rm.round)
	if rm.proposal != nil {
		log.Debug("already propose in this HR", rm.height, rm.round)
		return nil
	}
	if rm.cm.currentBlock != nil {
		log.Debug("block is prepared")
		block = rm.cm.currentBlock
	} else {
		log.Debug("block is not prepared")
		return nil
	}
	log.Info("in propose, check lastRoundLockset")
	roundLockset := rm.cm.lastRoundLockset()
	if roundLockset == nil && rm.round != 0 {
		log.Error("no valid round lockset for height", "height", rm.height, "round", rm.round)
		return nil
	}
	if rm.height != block.NumberU64() {
		fmt.Println("rm.height != block.NumberU64()", "rm.height:", rm.height, "blockNumber:", block.NumberU64())
		time.Sleep(100 * time.Millisecond)
		return rm.propose()
	}
	proposal = rm.mkProposal(roundLockset, block)
	rm.cm.addBlockCandidates(proposal)
	rm.proposal = proposal
	log.Debug("--------Leave rm.propose-------")

	if proposal.GetBlock() == nil {
		log.Info("In rm.propose, proposal.GetBlock is nil")
	}
	return proposal
}

func (rm *RoundManager) mkProposal(roundLockset *btypes.LockSet, block *types.Block) btypes.Proposal {
	log.Info("------in mkProposal------")
	signingLockset := rm.cm.lastCommittingLockset()
	if signingLockset == nil {
		log.Info("Do not have quorum lockset of last height")
		signingLockset = rm.cm.getLocksetByHeight(block.NumberU64() - 1)
		fmt.Println("signingLockset:", signingLockset)
	}
	var proposal btypes.Proposal
	if roundLockset != nil {
		log.Info("LockSet(R-1) Exist")
		// LockSet(R-1) Exist
		if quorumPossible, _ := roundLockset.QuorumPossible(); quorumPossible {
			log.Info("roundLockset has quorumPossible")
			// roundLockset has quorumPossible
			p, err := btypes.NewVotingInstruction(rm.height, rm.round, block, roundLockset)
			if err != nil {
				log.Info("in mkproposal, NewVotingInstruction failed")
				return nil
			}
			proposal = p
		} else {
			log.Info("roundLockset has noquorum")
			// roundLockset has noquorum
			p, err := btypes.NewBlockProposal(rm.height, rm.round, block, signingLockset, roundLockset)
			if err != nil {
				log.Info("in mkproposal, NewBlockProposal failed")
				return nil
			}
			proposal = p
		}
	} else {
		log.Info("LockSet(R-1) is nil (rm.round should equal to zero)")
		// LockSet(R-1) is nil, rm.round should equal to zero
		p, err := btypes.NewBlockProposal(rm.height, rm.round, block, signingLockset, roundLockset)
		if err != nil {
			return nil
		}
		proposal = p
	}
	rm.cm.Sign(proposal)
	fmt.Println("Create block blockhash : ", proposal.Blockhash())
	return proposal
}

func (rm *RoundManager) vote() *btypes.Vote {
	log.Info("---------------in rm.vote-----------------")
	if rm.voteLock != nil {
		log.Info("voted")
		return nil
	}
	log.Info("in vote in RM", "height", rm.height, "round", rm.round)
	lastVoteLock := rm.hm.LastVoteLock()
	roundTimeout := rm.cm.roundTimeout
	roundTimeoutFactor := rm.cm.roundTimeoutFactor
	delay := float64(roundTimeout) * math.Pow(roundTimeoutFactor, float64(rm.round)) / 2.0
	var vote *btypes.Vote
	if rm.mProposal != nil {
		log.Info("vote mp")
		p := rm.mProposal
		vote = btypes.NewVote(rm.height, rm.round, p.Blockhash(), 1)
	} else if rm.timeoutTime != 0 && float64(rm.cm.Now()) >= (rm.timeoutTime-delay) {
		if lastVoteLock != nil && lastVoteLock.VoteType == 1 {
			log.Info("vote previous vote")
			vote = btypes.NewVote(rm.height, rm.round, lastVoteLock.Blockhash, 1)
		} else {
			log.Info("vote nil")
			vote = btypes.NewVote(rm.height, rm.round, common.StringToHash(""), 2)
		}
	} else {
		log.Info("Timeout time not reach, curr vs timeout:", "curr", float64(rm.cm.Now()), "timeout", rm.timeoutTime)
		return nil
	}
	rm.cm.Sign(vote)
	log.Info("vote success in", "height", rm.height, "round", rm.round)
	rm.addVote(vote, false)
	log.Debug("----------------leave rm.vote----------------")
	return vote
}
