#!/bin/bash
# $1 total number of the node
# $2 size of block
# $3 number of the node in the ip

rm Address.txt
array=(10.0.1.176 10.0.1.129)
user=”ubuntu″
echo "------------pull Address from enode--------------"
for i in "${array[@]}"
do
        echo " cope $i"
        ssh -i ssh-fsbft.pem ubuntu@$i  cat /home/ubuntu/FastBFT_ethereum/experiment/Address.txt
        ssh -i ssh-fsbft.pem ubuntu@$i  cat /home/ubuntu/FastBFT_ethereum/experiment/Address.txt >> Address.txt
done

sleep 5.0

echo "-----write genesis.json and push back to enode------"

python writegenesis.py ${2}

for i in "${array[@]}"
do
        echo " cope genesis.json back to $i"
        scp -i ssh-fsbft.pem  /home/ubuntu/FastBFT_ethereum/experiment/genesis.json ubuntu@$i:/home/ubuntu/FastBFT_ethereum/experiment/genesis.json
done

