package main

import (
	"log"
	"fmt"
	"os"
	"time"
	"strconv"
	"context"
	"crypto/ecdsa"
	"./client"
	"math/big"
	"encoding/json"

	ethcommon "github.com/ethereum/go-ethereum/common"
	ethtypes "github.com/ethereum/go-ethereum/core/types"
	"github.com/ethereum/go-ethereum/crypto"
)

const (
	// DefaultGasPrice int64  = 18000000000
	DefaultGasPrice int64 = 18000

	// DefaultGasLimit is the gas of ether tx which should be 21000
	DefaultGasLimit uint64 = 21000
)

var (
	// OneWei = 10^1
	OneWei = big.NewInt(1)

	// OneKWei = 10^3
	OneKWei = new(big.Int).Mul(OneWei, big.NewInt(1000))

	// OneMWei = 10^6
	OneMWei = new(big.Int).Mul(OneKWei, big.NewInt(1000))

	// OneGWei = 10^9
	OneGWei = new(big.Int).Mul(OneMWei, big.NewInt(1000))

	// OneSzabo = 10^12
	OneSzabo = new(big.Int).Mul(OneGWei, big.NewInt(1000))

	// OneFinney = 10^15
	OneFinney = new(big.Int).Mul(OneSzabo, big.NewInt(1000))

	// OneEther = 10^18
	OneEther = new(big.Int).Mul(OneFinney, big.NewInt(1000))
)

type TxConf struct {
	PrvKeys  []string `json:"prvKeys"`
	RemiAddr []string `json:"remiAddr"`
	IpcPort  []string `json: "ipcPort"`
	TxCounts int      `json:"txCounts"`
}

var jsonString string = `{
	"prvKeys":["778c3019ee49e7001f67e8046938924fc82234d41f48eaacc9b760a1bbb6f871",
			   "73ab8ab12d9afeaed3481f336ec1b2a077ac7c4c5587137841e1952925ee9810",
			   "45b1f6021e3947e7ee274cb3e37f157da99587993fe5371df3dcfd5017b4e58d",
			   "d40c66a1a116e1479324d1d6a9df2ca9047e2614f510d9919efd27bbcc0a6b76",
			   "a358b3bf5ac2484cc3475b15df53f63ec4e694320301709761272048b0247de2",
			   "6e194b66ad2ef0503285c17a01284862b499313dd079da17b6d6ae3433d4681c",
			   "a953b2c6d1532a3fc81cdf014aaee56ab8de58aa12be408ba18f3e33a8ea7541",
			   "202590d3fcb6b7c152a6464b7004e56e5277b31237574982c4b85c2b7ba69e9d",
			   "2ac159947231815510710b95b1fb960e279dbd6d842408440c0718fe6b2d2049",
			   "8651388ff7433b33e89f89502c80062a7be60491b77d693e8337a81ac0ca79f8",
			   "e7f39c6f89d04766f9272250a4f58609d2840e758f1ac763d8eed9b5499bf0a5",
			   "edaae29050a720d5cceff0226726d8729059b0c50a80fcc693d50c7ab6b35173",
			   "7d25aa5cb8bdb467cf3f1851f7ab86dda27839531af3da877d799f0f836618dd",
			   "a17fdea85604280718b7297839eb8ae951454202dc2cb716e78e7d9bf9273b34",
			   "cb2f5e628cdee15c123e830118c7d13b01574cc189c41c58bfd486437504f78d",
			   "7c3fb4537a2d1ae5afc003bccf4d7637a34986cc5b9a6fb843f58819b0767426"
	],
	"remiAddr":["0x5b52a95f0f47f7b58a5b4c092d12ae8953838526",
				"0xc8d1bc936217e50d72b06b9dfc6d0006e8414d22",
				"0x5b52a95f0f47f7b58a5b4c092d12ae8953838526",
				"0xc8d1bc936217e50d72b06b9dfc6d0006e8414d22",
				"0x5b52a95f0f47f7b58a5b4c092d12ae8953838526",
				"0xc8d1bc936217e50d72b06b9dfc6d0006e8414d22",
				"0x5b52a95f0f47f7b58a5b4c092d12ae8953838526",
				"0xc8d1bc936217e50d72b06b9dfc6d0006e8414d22",
				"0x5b52a95f0f47f7b58a5b4c092d12ae8953838526",
				"0xc8d1bc936217e50d72b06b9dfc6d0006e8414d22",
				"0x5b52a95f0f47f7b58a5b4c092d12ae8953838526",
				"0xc8d1bc936217e50d72b06b9dfc6d0006e8414d22",
				"0x5b52a95f0f47f7b58a5b4c092d12ae8953838526",
				"0xc8d1bc936217e50d72b06b9dfc6d0006e8414d22",
				"0x5b52a95f0f47f7b58a5b4c092d12ae8953838526",
				"0xc8d1bc936217e50d72b06b9dfc6d0006e8414d22"
	],
	"ipcPort": ["./data/node1/geth.ipc",
				"./data/node2/geth.ipc",
				"./data/node3/geth.ipc",
				"./data/node4/geth.ipc",
				"./data/node5/geth.ipc",
				"./data/node6/geth.ipc",
				"./data/node7/geth.ipc",
				"./data/node8/geth.ipc",
				"./data/node9/geth.ipc",
				"./data/node10/geth.ipc",
				"./data/node11/geth.ipc",
				"./data/node12/geth.ipc",
				"./data/node13/geth.ipc",
				"./data/node14/geth.ipc",
				"./data/node15/geth.ipc",
				"./data/node16/geth.ipc"
	],
	"txCounts":10000
}`

func newSignedTransaction(from *ecdsa.PrivateKey, to ethcommon.Address,
	amount *big.Int, nonce uint64) (*ethtypes.Transaction, error) {

	tx := ethtypes.NewTransaction(nonce, to, amount,
		DefaultGasLimit, big.NewInt(DefaultGasPrice), []byte{})
	signedTx, err := ethtypes.SignTx(tx, ethtypes.HomesteadSigner{}, from)
	if err != nil {
		return nil, err
	}

	return signedTx, nil
}

func initConf() TxConf {
	var txConf TxConf
	err := json.Unmarshal([]byte(jsonString), &txConf)
	if err != nil {
		log.Fatalln(err)
	}
	return txConf
}

func makeClient(SenderPrivateKey string, IpcPort string) (client.EthClient, *ecdsa.PrivateKey) {
	from, err := crypto.HexToECDSA(SenderPrivateKey)
	if err != nil {
		panic(err)
	}
	// try to connect Ethereum via WebSocket, you can replace it with IPC endpoint or http url
	// client, err := client.EthClientDial("./data/node1/geth.ipc")
	client, err := client.EthClientDial(IpcPort)
	if err != nil {
		panic(err)
	}
	return client, from
}

func makeTxs(txCount int, from *ecdsa.PrivateKey, RemitteeAddress string, currentNonce uint64) ([]*ethtypes.Transaction) {
	// remittee's Ethereum Address
	to := ethcommon.HexToAddress(RemitteeAddress)
	fmt.Println("Start to send txs from:", from, "to", to)
	//currentNonce := uint64(0)
	// transactions to send
	txs := make([]*ethtypes.Transaction, txCount)
	// FIXME You should parallelize this
	for i := 0; i < txCount; i++ {
		// create new signed transaction
		tx, err := newSignedTransaction(from, to, OneFinney, currentNonce)
		if err != nil {
			panic(err)
		}
		txs[i] = tx
		currentNonce++
	}
	fmt.Println("finished list of txs creation, there are:", txCount, "txs")
	return txs
}

func sendTxs(client client.EthClient, txs []*ethtypes.Transaction) {
	// send transactions one after another
	// defer client.Close()
	for _, tx := range txs {
		if err := client.SendRawTransaction(context.Background(), tx); err != nil {
			panic(err)
		}
	}
	fmt.Println("finished txs sending")
}

func main() {
	fmt.Println("------start sendtx------")
	txConf := initConf()
	var txs []*ethtypes.Transaction
	var currentNonce = uint64(0)
	var (
		SenderPrivateKey = txConf.PrvKeys
		RemitteeAddress  = txConf.RemiAddr
		IpcPorts         = txConf.IpcPort
		txCount          = txConf.TxCounts
		NodesNum, _      = strconv.Atoi(os.Args[1])
		NodeIndex, _     = strconv.Atoi(os.Args[2])
	)
	
	
	for test := 0; test < 50; test ++ {
		fmt.Println("Experiment of ", NodesNum, "nodes")
		client, from := makeClient(SenderPrivateKey[NodeIndex-1], IpcPorts[NodeIndex-1])
		defer client.Close()
		
		txs = makeTxs(txCount, from, RemitteeAddress[NodeIndex-1], currentNonce)
		sendTxs(client, txs)
		currentNonce += uint64(txCount)
		fmt.Println("Test", test, "nounce:", currentNonce)
		time.Sleep(7 * time.Second)
	}
}
