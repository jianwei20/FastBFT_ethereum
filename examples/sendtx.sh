# ${1}: local/aws
# ${2}: number of nodes, 4/8/12/16
# ${3}: index of node1 ~ node16

rm sendtx.log
start=`date +%s`
# start adding txs into txpool
if [ ${1} == "local" ];then
	nohup ./ethclient/ethclient ${2} &> sendtx.log & 
elif [ ${1} == "aws" ];then
	nohup ./aws-ethclient/aws-ethclient ${2} ${3} &> sendtx.log &
fi
echo "--------in sendtx.sh--------"
end=`date +%s`
echo execution time was `expr $end - $start` s.
