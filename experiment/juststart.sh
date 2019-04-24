#!/bin/bash
# $1 total number of the node
# $2 size of block
# $3 number of the node in the ip
rm enode.txt
rm static-nodes.json
array=(10.0.1.159 10.0.1.99 10.0.1.68 10.0.1.101 10.0.1.214 10.0.1.118 10.0.1.8 10.0.1.185 10.0.1.221 10.0.1.14)
user="ubuntu"

x=1
for i in "${array[@]}";
do
y=1
while (($y<=$3))
do
        echo "start node $x in node$y"
        ssh -i ssh-fsbft.pem ubuntu@$i "cd /home/ubuntu/FastBFT_ethereum/experiment; nohup sh /home/ubuntu/FastBFT_ethereum/experiment/node${x}.sh &> /home/ubuntu/FastBFT_ethereum/experiment/data1/n${x}.log &"
        ((x++));
        ((y++));
done
done
