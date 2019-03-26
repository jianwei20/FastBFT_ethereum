#!/bin/bash
# $1 total number of the node
# $2 size of block
# $3 number of the node in the ip

rm Address.txt
array=(10.0.1.70 10.0.1.65)
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

echo "------write each nodes execute shell and push back to enode-----"

rm nodeConfig1/$1nodes/node*.sh
python writeNodeShell.py ${1} ${2} ${3}
chmod +u+x /home/ubuntu/FastBFT_ethereum/experiment/nodeConfig1/$1nodes/node*.sh
t=1
for i in "${array[@]}"
do
for ((x=1;x<= ${3};x++))
do
        echo "cope execute shell node$t  back to $i"
        scp -i ssh-fsbft.pem  /home/ubuntu/FastBFT_ethereum/experiment/nodeConfig1/$1nodes/node$t.sh ubuntu@$i:/home/ubuntu/FastBFT_ethereum/experiment/
        ((t++))
done
done
