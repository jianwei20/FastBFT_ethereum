# ${1}: local/aws 
# ${2}: number of nodes, 4/8/12/16
# ${3}: index of node1 ~ node16


echo "------In run-miner.sh, start ${2} nodes------"

for ((i=1;i<${2}+1;i++));
do 
	../build/bin/geth --exec 'miner.start(1)' attach ipc:./data1/node$i/geth.ipc

done
