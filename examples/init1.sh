#!/bin/bash
echo "-------In init1.sh--------"

rm -rf ./data1
rm ./data1/*.log


for ((i=1;i<=${1};i++));
do 

../build/bin/geth --datadir "data1/node${i}" init genesis.json

done
