#!/bin/bash
# $1 total number of the node
# $2 size of block
# $3 number of the node in the ip

echo "---------writejson.py--------------"

python writejson.py
sleep 1.0
echo "-------go build ethclient-----------"
go build ethclient/main.go

sleep 3.0

echo "-----------send.tx---------------"

./sendtx.sh local $3


sleep 10.0


./run-miner.sh local $3

sleep 20.0

