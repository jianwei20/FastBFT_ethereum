package client

import (
	"context"
	"math/big"

	"github.com/ethereum/go-ethereum/common"
	"github.com/ethereum/go-ethereum/common/hexutil"
	ethtypes "github.com/ethereum/go-ethereum/core/types"
	gethclient "github.com/ethereum/go-ethereum/ethclient"
	"github.com/ethereum/go-ethereum/p2p"
	"github.com/ethereum/go-ethereum/rlp"
	"github.com/ethereum/go-ethereum/rpc"
)

func toBlockNumArg(number *big.Int) string {
	if number == nil {
		return "latest"
	}
	return hexutil.EncodeBig(number)
}

type ethClient struct {
	rpcClient *rpc.Client
	ethClient *gethclient.Client
	closed    bool
}

func EthClientDial(endpoint string) (EthClient, error) {
	c, err := rpc.Dial(endpoint)
	if err != nil {
		return nil, err
	}
	return &ethClient{
		rpcClient: c,
		ethClient: gethclient.NewClient(c),
		closed:    false,
	}, nil
}

func (c *ethClient) Closed() bool { return c.closed }

func (c *ethClient) Close() {
	c.closed = true
	c.rpcClient.Close()
}

// ----------------------------------------------------------------------------
func (c *ethClient) PeerCount(ctx context.Context) (uint, error) {
	var r hexutil.Uint
	err := c.rpcClient.CallContext(ctx, &r, "net_peerCount")
	return uint(r), err
}

func (c *ethClient) AddPeer(ctx context.Context, nodeURL string) (bool, error) {
	var r bool
	var err error
	// TODO: Result needs to be verified
	// The response data type are bytes, but we cannot parse...

	err = c.rpcClient.CallContext(ctx, &r, "admin_addPeer", nodeURL)
	return r, err
}

func (c *ethClient) AddPeers(ctx context.Context, enodeURLs []string) []error {
	var errs []error
	for _, url := range enodeURLs {
		_, err := c.AddPeer(ctx, url)
		errs = append(errs, err)
	}
	return errs
}

func (c *ethClient) AdminPeers(ctx context.Context) ([]*p2p.PeerInfo, error) {
	var r []*p2p.PeerInfo
	var err error
	// The response data type are bytes, but we cannot parse...
	err = c.rpcClient.CallContext(ctx, &r, "admin_peers")
	return r, err
}

func (c *ethClient) NodeInfo(ctx context.Context) (*p2p.PeerInfo, error) {
	var r *p2p.PeerInfo
	err := c.rpcClient.CallContext(ctx, &r, "admin_nodeInfo")
	if err != nil {
		return nil, err
	}
	return r, err
}

// ----------------------------------------------------------------------------
func (c *ethClient) BlockNumber(ctx context.Context) (*big.Int, error) {
	var r string
	err := c.rpcClient.CallContext(ctx, &r, "eth_blockNumber")
	if err != nil {
		return nil, err
	}
	h, err := hexutil.DecodeBig(r)
	return h, err
}

func (c *ethClient) StartMining(ctx context.Context) error {
	return c.rpcClient.CallContext(ctx, nil, "miner_start", nil)
}

func (c *ethClient) StopMining(ctx context.Context) error {
	return c.rpcClient.CallContext(ctx, nil, "miner_stop", nil)
}

func (c *ethClient) Mining(ctx context.Context) (bool, error) {
	var r bool
	err := c.rpcClient.CallContext(ctx, &r, "eth_mining")
	return r, err
}

func (c *ethClient) NetworkID(ctx context.Context) (*big.Int, error) {
	return c.ethClient.NetworkID(ctx)
}

func (c *ethClient) BalanceAt(ctx context.Context, account common.Address, blockNumber *big.Int) (*big.Int, error) {
	return c.ethClient.BalanceAt(ctx, account, blockNumber)
}

func (c *ethClient) StorageAt(ctx context.Context, account common.Address, key common.Hash, blockNumber *big.Int) ([]byte, error) {
	return c.ethClient.StorageAt(ctx, account, key, blockNumber)
}

func (c *ethClient) CodeAt(ctx context.Context, account common.Address, blockNumber *big.Int) ([]byte, error) {
	return c.ethClient.CodeAt(ctx, account, blockNumber)
}

func (c *ethClient) NonceAt(ctx context.Context, account common.Address, blockNumber *big.Int) (uint64, error) {
	return c.ethClient.NonceAt(ctx, account, blockNumber)
}

func (c *ethClient) PendingNonceAt(ctx context.Context, account common.Address) (uint64, error) {
	return c.ethClient.PendingNonceAt(ctx, account)
}

func (c *ethClient) PendingBalanceAt(ctx context.Context, account common.Address) (*big.Int, error) {
	return c.ethClient.PendingBalanceAt(ctx, account)
}

func (c *ethClient) PendingTransactionCount(ctx context.Context) (uint, error) {
	return c.ethClient.PendingTransactionCount(ctx)
}

func (c *ethClient) BlockByHash(ctx context.Context, hash common.Hash) (*ethtypes.Block, error) {
	return c.ethClient.BlockByHash(ctx, hash)
}

func (c *ethClient) BlockByNumber(ctx context.Context, number *big.Int) (*ethtypes.Block, error) {
	return c.ethClient.BlockByNumber(ctx, number)
}

func (c *ethClient) SendRawTransaction(ctx context.Context, tx *ethtypes.Transaction) error {
	return c.ethClient.SendTransaction(ctx, tx)
}

func (c *ethClient) BlockTransactionCount(ctx context.Context, blockNumber *big.Int) (uint, error) {
	var num hexutil.Uint
	err := c.rpcClient.CallContext(ctx, &num,
		"eth_getBlockTransactionCountByNumber", toBlockNumArg(blockNumber))
	return uint(num), err
}

func (c *ethClient) BlockHeaderByNumber(ctx context.Context, number *big.Int) (*ethtypes.Header, error) {
	return c.ethClient.HeaderByNumber(ctx, number)
}

func (c *ethClient) BlockHeaderByHash(ctx context.Context, hash common.Hash) (*ethtypes.Header, error) {
	return c.ethClient.HeaderByHash(ctx, hash)
}

func (c *ethClient) SendBatchRawTransaction(ctx context.Context, txs []*ethtypes.Transaction) error {

	batchElements := make([]rpc.BatchElem, len(txs))
	for i := range txs {
		data, err := rlp.EncodeToBytes(txs[i])
		if err != nil {
			return err
		}

		batchElements[i] = rpc.BatchElem{
			Method: "eth_sendRawTransaction",
			Args:   []interface{}{common.ToHex(data)},
			Result: nil,
		}
	}

	return c.rpcClient.BatchCallContext(ctx, batchElements)
}

func (c *ethClient) TxPoolStatus(ctx context.Context) (map[string]uint64, error) {
	var status map[string]hexutil.Uint
	err := c.rpcClient.CallContext(ctx, &status, "txpool_status")

	rlt := make(map[string]uint64)
	for k, v := range status {
		rlt[k] = uint64(v)
	}
	return rlt, err
}
