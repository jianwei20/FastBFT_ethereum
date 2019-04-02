#!/bin/bash
# $1 total number of the node
# $2 size of block
# $3 number of the node in the ip

/usr/local/go/bin/go version
echo "---------writejson1.py--------------"

python writejson.py
sleep 1.0
echo "-------go build ethclient-----------"

cd  /home/ubuntu/FastBFT_ethereum/experiment/ethclient

/usr/local/go/bin/go build

cd ..
sleep 3.0

echo "-----------send.tx---------------"

./sendtx.sh local $3


sleep 10.0

cat sendtx.log

./run-miner.sh local $3

sleep 20.0

~