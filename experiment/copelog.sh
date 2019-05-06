#!/bin/bash
# $1 total number of the node
# $2 size of block
# $3 number of the node in the ip
rm -rf result1
mkdir result1/

array=(10.0.1.70 10.0.1.65)
user=”ubuntu″
echo "------------pull Address from enode--------------"

t=1
for i in "${array[@]}"
do
for ((x=1;x<= ${3};x++))
do
        echo "cope log  back to result"
        scp -i ssh-fsbft.pem ubuntu@$i:/home/ubuntu/FastBFT_ethereum/experiment/data1/n$t.log /home/ubuntu/FastBFT_ethereum/experiment/result1
        ((t++))
done
done
