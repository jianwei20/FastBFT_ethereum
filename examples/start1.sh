#!/bin/bash

# ${1}: local/aws 
# ${2}: number of nodes, 4/8/12/16
# ${3}: index of node1 ~ node16

echo "------In start.sh, start ${2} nodes------"
for ((i=1;i<${2}+1;i++));
do 
nohup ./node${i}.sh &> data1/n${i}.log &
done


