#!/bin/bash
# $1 total number of the node
# $2 size of block
# $3 number of the node in the ip
rm enode.txt
rm static-nodes.json
array=(10.0.1.123 10.0.1.66)
user="ubuntu"

echo "------In start.sh, start ${1} nodes------"

x=1
for i in "${array[@]}";
do
y=1
while (($y<=$3))
do
        echo "start node $x in node$y"
        ssh -i ssh-fsbft.pem ubuntu@$i "cd /home/ubuntu/FastBFT_ethereum/experiment; nohup sh /home/ubuntu/FastBFT_ethereum/experiment/node${x}.sh&"
        ssh -i ssh-fsbft.pem ubuntu@$i "cd /home/ubuntu/FastBFT_ethereum/experiment; echo "$i" ; ../build/bin/geth --exec 'admin.nodeInfo.enode' attach ipc:/home/ubuntu/FastBFT_ethereum/experiment/data1/node${y}/geth.ipc">>enode.txt
        ((x++));
        ((y++));
done
done

python getenode1.py


for i in "${array[@]}"
do
for ((x=1;x<= ${3};x++))
do
        echo "cope static-node.json $t  back to $i"
        scp -i ssh-fsbft.pem  /home/ubuntu/FastBFT_ethereum/experiment/static-nodes.json ubuntu@$i:/home/ubuntu/FastBFT_ethereum/experiment/data1/node$x
        ((t++))
done
done

echo "------stop nodes------"

for i in "${array[@]}";
do
 echo "stop  node  in $i"
        ssh -i ssh-fsbft.pem ubuntu@$i "cd /home/ubuntu/FastBFT_ethereum/experiment;  sh /home/ubuntu/FastBFT_ethereum/experiment/stop.sh"
done

echo "------In start.sh, start ${1} nodes------"

x=1
for i in "${array[@]}";
do
y=1
while (($y<=$3))
do
        echo "start node $x in node$y"
        ssh -i ssh-fsbft.pem ubuntu@$i "cd /home/ubuntu/FastBFT_ethereum/experiment; nohup sh /home/ubuntu/FastBFT_ethereum/experiment/node${x}.sh &> /home/ubuntu/FastBFT_ethereum/experiment/data1/n${x}.log &"
        ssh -i ssh-fsbft.pem ubuntu@$i "cd /home/ubuntu/FastBFT_ethereum/experiment; echo "$i" ; ../build/bin/geth --exec 'admin.nodeInfo.enode' attach ipc:/home/ubuntu/FastBFT_ethereum/experiment/data1/node${y}/geth.ipc">>enode.txt
        ((x++));
        ((y++));
done
done