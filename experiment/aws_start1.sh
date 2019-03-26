#!/bin/bash
# $1 total number of the node
# $2 size of block
# $3 number of the node in the ip

array=(10.0.1.227 10.0.1.252)
user=”ubuntu″

echo "------In start.sh, start ${1} nodes------"

x=1
for i in "${array[@]}";
do
y=1
while (($y<=$3))
do
        echo "start node $x in node$y"
        ssh -i ssh-fsbft.pem ubuntu@$i "cd /home/ubuntu/FastBFT_ethereum/experiment; nohup sh /home/ubuntu/FastBFT_ethereum/experiment/node${x}.sh &> /home/ubuntu/FastBFT_ethereum/experiment/data1/n${x}.log &"
         ssh -i ssh-fsbft.pem ubuntu@$i "pwd"
        #ssh -i ssh-fsbft.pem ubuntu@$i "cd /home/ubuntu/FastBFT_ethereum/experiment; ../build/bin/geth --exec 'admin.nodeInfo.enode' attach ipc:/home/ubuntu/FastBFT_ethereum/experiment/data1/node${y}/geth.ipc >> enode.txt"
        ((x++));
        ((y++));
done
done
~