# ${1}: local/aws 
# ${2}: number of nodes, 4/8/12/16
# ${3}: index of node1 ~ node16


echo "------In run-miner.sh, start ${2} nodes------"
if [ ${1} == "local" ];then
	if [ ${2} == "4" ];then
		../build/bin/geth --exec 'miner.start(1)' attach ipc:./data1/node1/geth.ipc
		../build/bin/geth --exec 'miner.start(1)' attach ipc:./data1/node2/geth.ipc
		../build/bin/geth --exec 'miner.start(1)' attach ipc:./data1/node3/geth.ipc
		../build/bin/geth --exec 'miner.start(1)' attach ipc:./data1/node4/geth.ipc
	elif [ ${2} == "8" ];then
		../build/bin/geth --exec 'miner.start(1)' attach ipc:./data/node1/geth.ipc
		../build/bin/geth --exec 'miner.start(1)' attach ipc:./data/node2/geth.ipc
		../build/bin/geth --exec 'miner.start(1)' attach ipc:./data/node3/geth.ipc
		../build/bin/geth --exec 'miner.start(1)' attach ipc:./data/node4/geth.ipc
		../build/bin/geth --exec 'miner.start(1)' attach ipc:./data/node5/geth.ipc
		../build/bin/geth --exec 'miner.start(1)' attach ipc:./data/node6/geth.ipc
		../build/bin/geth --exec 'miner.start(1)' attach ipc:./data/node7/geth.ipc
		../build/bin/geth --exec 'miner.start(1)' attach ipc:./data/node8/geth.ipc
	elif [ ${2} == "12" ];then
		../build/bin/geth --exec 'miner.start(1)' attach ipc:./data/node1/geth.ipc
		../build/bin/geth --exec 'miner.start(1)' attach ipc:./data/node2/geth.ipc
		../build/bin/geth --exec 'miner.start(1)' attach ipc:./data/node3/geth.ipc
		../build/bin/geth --exec 'miner.start(1)' attach ipc:./data/node4/geth.ipc
		../build/bin/geth --exec 'miner.start(1)' attach ipc:./data/node5/geth.ipc
		../build/bin/geth --exec 'miner.start(1)' attach ipc:./data/node6/geth.ipc
		../build/bin/geth --exec 'miner.start(1)' attach ipc:./data/node7/geth.ipc
		../build/bin/geth --exec 'miner.start(1)' attach ipc:./data/node8/geth.ipc
		../build/bin/geth --exec 'miner.start(1)' attach ipc:./data/node9/geth.ipc
		../build/bin/geth --exec 'miner.start(1)' attach ipc:./data/node10/geth.ipc
		../build/bin/geth --exec 'miner.start(1)' attach ipc:./data/node11/geth.ipc
		../build/bin/geth --exec 'miner.start(1)' attach ipc:./data/node12/geth.ipc
	elif [ ${2} == "16" ];then
		../build/bin/geth --exec 'miner.start(1)' attach ipc:./data/node1/geth.ipc
		../build/bin/geth --exec 'miner.start(1)' attach ipc:./data/node2/geth.ipc
		../build/bin/geth --exec 'miner.start(1)' attach ipc:./data/node3/geth.ipc
		../build/bin/geth --exec 'miner.start(1)' attach ipc:./data/node4/geth.ipc
		../build/bin/geth --exec 'miner.start(1)' attach ipc:./data/node5/geth.ipc
		../build/bin/geth --exec 'miner.start(1)' attach ipc:./data/node6/geth.ipc
		../build/bin/geth --exec 'miner.start(1)' attach ipc:./data/node7/geth.ipc
		../build/bin/geth --exec 'miner.start(1)' attach ipc:./data/node8/geth.ipc
		../build/bin/geth --exec 'miner.start(1)' attach ipc:./data/node9/geth.ipc
		../build/bin/geth --exec 'miner.start(1)' attach ipc:./data/node10/geth.ipc
		../build/bin/geth --exec 'miner.start(1)' attach ipc:./data/node11/geth.ipc
		../build/bin/geth --exec 'miner.start(1)' attach ipc:./data/node12/geth.ipc
		../build/bin/geth --exec 'miner.start(1)' attach ipc:./data/node13/geth.ipc
		../build/bin/geth --exec 'miner.start(1)' attach ipc:./data/node14/geth.ipc
		../build/bin/geth --exec 'miner.start(1)' attach ipc:./data/node15/geth.ipc
		../build/bin/geth --exec 'miner.start(1)' attach ipc:./data/node16/geth.ipc
    elif [ ${2} == "32" ];then
		../build/bin/geth --exec 'miner.start(1)' attach ipc:./data/node1/geth.ipc
		../build/bin/geth --exec 'miner.start(1)' attach ipc:./data/node2/geth.ipc
		../build/bin/geth --exec 'miner.start(1)' attach ipc:./data/node3/geth.ipc
		../build/bin/geth --exec 'miner.start(1)' attach ipc:./data/node4/geth.ipc
		../build/bin/geth --exec 'miner.start(1)' attach ipc:./data/node5/geth.ipc
		../build/bin/geth --exec 'miner.start(1)' attach ipc:./data/node6/geth.ipc
		../build/bin/geth --exec 'miner.start(1)' attach ipc:./data/node7/geth.ipc
		../build/bin/geth --exec 'miner.start(1)' attach ipc:./data/node8/geth.ipc
		../build/bin/geth --exec 'miner.start(1)' attach ipc:./data/node9/geth.ipc
		../build/bin/geth --exec 'miner.start(1)' attach ipc:./data/node10/geth.ipc
		../build/bin/geth --exec 'miner.start(1)' attach ipc:./data/node11/geth.ipc
		../build/bin/geth --exec 'miner.start(1)' attach ipc:./data/node12/geth.ipc
		../build/bin/geth --exec 'miner.start(1)' attach ipc:./data/node13/geth.ipc
		../build/bin/geth --exec 'miner.start(1)' attach ipc:./data/node14/geth.ipc
		../build/bin/geth --exec 'miner.start(1)' attach ipc:./data/node15/geth.ipc
		../build/bin/geth --exec 'miner.start(1)' attach ipc:./data/node16/geth.ipc
		../build/bin/geth --exec 'miner.start(1)' attach ipc:./data/node17/geth.ipc
		../build/bin/geth --exec 'miner.start(1)' attach ipc:./data/node18/geth.ipc
		../build/bin/geth --exec 'miner.start(1)' attach ipc:./data/node19/geth.ipc
		../build/bin/geth --exec 'miner.start(1)' attach ipc:./data/node20/geth.ipc
		../build/bin/geth --exec 'miner.start(1)' attach ipc:./data/node21/geth.ipc
		../build/bin/geth --exec 'miner.start(1)' attach ipc:./data/node22/geth.ipc
		../build/bin/geth --exec 'miner.start(1)' attach ipc:./data/node23/geth.ipc
		../build/bin/geth --exec 'miner.start(1)' attach ipc:./data/node24/geth.ipc
		../build/bin/geth --exec 'miner.start(1)' attach ipc:./data/node25/geth.ipc
		../build/bin/geth --exec 'miner.start(1)' attach ipc:./data/node26/geth.ipc
		../build/bin/geth --exec 'miner.start(1)' attach ipc:./data/node27/geth.ipc
		../build/bin/geth --exec 'miner.start(1)' attach ipc:./data/node28/geth.ipc
		../build/bin/geth --exec 'miner.start(1)' attach ipc:./data/node29/geth.ipc
		../build/bin/geth --exec 'miner.start(1)' attach ipc:./data/node30/geth.ipc
		../build/bin/geth --exec 'miner.start(1)' attach ipc:./data/node31/geth.ipc
		../build/bin/geth --exec 'miner.start(1)' attach ipc:./data/node32/geth.ipc
	fi


elif [ ${1} == "aws" ];then	
	if [ ${2} == "4" ];then
		if [ ${3} == "1" ]; then
			../build/bin/geth --exec 'miner.start(1)' attach ipc:./data/node1/geth.ipc
		elif [ ${3} == "2" ]; then
			../build/bin/geth --exec 'miner.start(1)' attach ipc:./data/node2/geth.ipc
		elif [ ${3} == "3" ]; then
			../build/bin/geth --exec 'miner.start(1)' attach ipc:./data/node3/geth.ipc
		elif [ ${3} == "4" ]; then
			../build/bin/geth --exec 'miner.start(1)' attach ipc:./data/node4/geth.ipc
		fi
	elif [ ${2} == "8" ];then
		if [ ${3} == "1" ]; then
			../build/bin/geth --exec 'miner.start(1)' attach ipc:./data/node1/geth.ipc
		elif [ ${3} == "2" ]; then
			../build/bin/geth --exec 'miner.start(1)' attach ipc:./data/node2/geth.ipc
		elif [ ${3} == "3" ]; then
			../build/bin/geth --exec 'miner.start(1)' attach ipc:./data/node3/geth.ipc
		elif [ ${3} == "4" ]; then
			../build/bin/geth --exec 'miner.start(1)' attach ipc:./data/node4/geth.ipc
		elif [ ${3} == "5" ]; then
			../build/bin/geth --exec 'miner.start(1)' attach ipc:./data/node5/geth.ipc
		elif [ ${3} == "6" ]; then
			../build/bin/geth --exec 'miner.start(1)' attach ipc:./data/node6/geth.ipc
		elif [ ${3} == "7" ]; then
			../build/bin/geth --exec 'miner.start(1)' attach ipc:./data/node7/geth.ipc
		elif [ ${3} == "8" ]; then
			../build/bin/geth --exec 'miner.start(1)' attach ipc:./data/node8/geth.ipc
		fi
	elif [ ${2} == "12" ];then
		if [ ${3} == "1" ]; then
			../build/bin/geth --exec 'miner.start(1)' attach ipc:./data/node1/geth.ipc
		elif [ ${3} == "2" ]; then
			../build/bin/geth --exec 'miner.start(1)' attach ipc:./data/node2/geth.ipc
		elif [ ${3} == "3" ]; then
			../build/bin/geth --exec 'miner.start(1)' attach ipc:./data/node3/geth.ipc
		elif [ ${3} == "4" ]; then
			../build/bin/geth --exec 'miner.start(1)' attach ipc:./data/node4/geth.ipc
		elif [ ${3} == "5" ]; then
			../build/bin/geth --exec 'miner.start(1)' attach ipc:./data/node5/geth.ipc
		elif [ ${3} == "6" ]; then
			../build/bin/geth --exec 'miner.start(1)' attach ipc:./data/node6/geth.ipc
		elif [ ${3} == "7" ]; then
			../build/bin/geth --exec 'miner.start(1)' attach ipc:./data/node7/geth.ipc
		elif [ ${3} == "8" ]; then
			../build/bin/geth --exec 'miner.start(1)' attach ipc:./data/node8/geth.ipc
		elif [ ${3} == "9" ]; then
			../build/bin/geth --exec 'miner.start(1)' attach ipc:./data/node9/geth.ipc
		elif [ ${3} == "10" ]; then
			../build/bin/geth --exec 'miner.start(1)' attach ipc:./data/node10/geth.ipc
		elif [ ${3} == "11" ]; then
			../build/bin/geth --exec 'miner.start(1)' attach ipc:./data/node11/geth.ipc
		elif [ ${3} == "12" ]; then
			../build/bin/geth --exec 'miner.start(1)' attach ipc:./data/node12/geth.ipc
		fi
	elif [ ${2} == "16" ];then
		if [ ${3} == "1" ]; then
			../build/bin/geth --exec 'miner.start(1)' attach ipc:./data/node1/geth.ipc
		elif [ ${3} == "2" ]; then
			../build/bin/geth --exec 'miner.start(1)' attach ipc:./data/node2/geth.ipc
		elif [ ${3} == "3" ]; then
			../build/bin/geth --exec 'miner.start(1)' attach ipc:./data/node3/geth.ipc
		elif [ ${3} == "4" ]; then
			../build/bin/geth --exec 'miner.start(1)' attach ipc:./data/node4/geth.ipc
		elif [ ${3} == "5" ]; then
			../build/bin/geth --exec 'miner.start(1)' attach ipc:./data/node5/geth.ipc
		elif [ ${3} == "6" ]; then
			../build/bin/geth --exec 'miner.start(1)' attach ipc:./data/node6/geth.ipc
		elif [ ${3} == "7" ]; then
			../build/bin/geth --exec 'miner.start(1)' attach ipc:./data/node7/geth.ipc
		elif [ ${3} == "8" ]; then
			../build/bin/geth --exec 'miner.start(1)' attach ipc:./data/node8/geth.ipc
		elif [ ${3} == "9" ]; then
			../build/bin/geth --exec 'miner.start(1)' attach ipc:./data/node9/geth.ipc
		elif [ ${3} == "10" ]; then
			../build/bin/geth --exec 'miner.start(1)' attach ipc:./data/node10/geth.ipc
		elif [ ${3} == "11" ]; then
			../build/bin/geth --exec 'miner.start(1)' attach ipc:./data/node11/geth.ipc
		elif [ ${3} == "12" ]; then
			../build/bin/geth --exec 'miner.start(1)' attach ipc:./data/node12/geth.ipc
		elif [ ${3} == "13" ]; then
			../build/bin/geth --exec 'miner.start(1)' attach ipc:./data/node13/geth.ipc
		elif [ ${3} == "14" ]; then
			../build/bin/geth --exec 'miner.start(1)' attach ipc:./data/node14/geth.ipc
		elif [ ${3} == "15" ]; then
			../build/bin/geth --exec 'miner.start(1)' attach ipc:./data/node15/geth.ipc
		elif [ ${3} == "16" ]; then
			../build/bin/geth --exec 'miner.start(1)' attach ipc:./data/node16/geth.ipc
		fi
	fi
fi
