#!/bin/bash
# $1 total number of the node
# $2 size of block
# $3 number of the node in the ip

array=(10.0.1.70 10.0.1.65)
user=”ubuntu″
echo "------------pull Address from enode--------------"
x=1
for i in "${array[@]}";
do
y=1
while (($y<=$3))
do
        echo " cope $x"
        ssh -i ssh-fsbft.pem ubuntu@$i nohup ./home/ubuntu/FastBFT_ethereum/experiment/node$x.sh &> test.log
        ((x++));
        ((y++));
done
done
