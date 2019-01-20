package client

import (
	"context"
	"math/big"

	"github.com/ethereum/go-ethereum/common"
	ethtypes "github.com/ethereum/go-ethereum/core/types"
	"github.com/ethereum/go-ethereum/p2p"
)

// EthClient ...
type EthClient interface {
	Close()
	Closed() bool

	StartMining(ctx context.Context) error
	StopMining(ctx context.Context) error
	Mining(ctx context.Context) (bool, error)

	PeerCount(ctx context.Context) (uint, error)
	AdminPeers(ctx context.Context) ([]*p2p.PeerInfo, error)
	AddPeer(ctx context.Context, enodeURL string) (bool, error)
	AddPeers(ctx context.Context, enodeURLs []string) []error

	BlockNumber(ctx context.Context) (*big.Int, error)
	NodeInfo(ctx context.Context) (*p2p.PeerInfo, error)

	NetworkID(ctx context.Context) (*big.Int, error)
	BalanceAt(ctx context.Context, account common.Address, blockNumber *big.Int) (*big.Int, error)
	StorageAt(ctx context.Context, account common.Address, key common.Hash, blockNumber *big.Int) ([]byte, error)
	CodeAt(ctx context.Context, account common.Address, blockNumber *big.Int) ([]byte, error)
	NonceAt(ctx context.Context, account common.Address, blockNumber *big.Int) (uint64, error)
	PendingNonceAt(ctx context.Context, account common.Address) (uint64, error)
	PendingBalanceAt(ctx context.Context, account common.Address) (*big.Int, error)

	BlockHeaderByNumber(ctx context.Context, number *big.Int) (*ethtypes.Header, error)
	BlockHeaderByHash(ctx context.Context, hash common.Hash) (*ethtypes.Header, error)
	BlockTransactionCount(ctx context.Context, blockNumber *big.Int) (uint, error)
	BlockByHash(ctx context.Context, hash common.Hash) (*ethtypes.Block, error)
	BlockByNumber(ctx context.Context, number *big.Int) (*ethtypes.Block, error)

	SendRawTransaction(ctx context.Context, tx *ethtypes.Transaction) error
	SendBatchRawTransaction(ctx context.Context, txs []*ethtypes.Transaction) error

	PendingTransactionCount(ctx context.Context) (uint, error)

	TxPoolStatus(ctx context.Context) (map[string]uint64, error)
}
