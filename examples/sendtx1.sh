#!/bin/bash
# ${1}: local/aws
# ${2}: number of nodes, 4/8/12/16
# ${3}: index of node1 ~ node16
rm sendtx.log
start=`date +%s`
nohup ./ethclient/ethclient ${2} &> sendtx.log &
echo "--------in sendtx.sh--------"
end=`date +%s`
echo execution time was `expr $end - $start` s.

