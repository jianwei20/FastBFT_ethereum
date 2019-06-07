#!/bin/bash
# $1 total number of the node
# $2 size of block
# $3 number of the node in the ip

/usr/local/go/bin/go version
echo "---------writejson1.py--------------"

python writejson.py

echo "-------go build ethclient-----------"

cd  /home/ubuntu/FastBFT_ethereum/experiment/ethclient

/usr/local/go/bin/go build

cd ..


echo "-----------send.tx---------------"

./sendtx.sh local $3


sleep 1.0

cat sendtx.log

