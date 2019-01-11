# ${1}: local/aws 
# ${2}: number of nodes, 4/8/12/16
# ${3}: index of node1 ~ node16

echo "------In start.sh, start ${2} nodes------"
if [ ${1} == "local" ];then
	if [ ${2} == "4" ];then
		nohup ./node1.sh &> data/n1.log &
		nohup ./node2.sh &> data/n2.log &
		nohup ./node3.sh &> data/n3.log &
		nohup ./node4.sh &> data/n4.log &
	elif [ ${2} == "8" ];then
		nohup ./node1.sh &> data/n1.log &
		nohup ./node2.sh &> data/n2.log &
		nohup ./node3.sh &> data/n3.log &
		nohup ./node4.sh &> data/n4.log &
		nohup ./node5.sh &> data/n5.log &
		nohup ./node6.sh &> data/n6.log &
		nohup ./node7.sh &> data/n7.log &
		nohup ./node8.sh &> data/n8.log &
	elif [ ${2} == "12" ];then
		nohup ./node1.sh &> data/n1.log &
		nohup ./node2.sh &> data/n2.log &
		nohup ./node3.sh &> data/n3.log &
		nohup ./node4.sh &> data/n4.log &
		nohup ./node5.sh &> data/n5.log &
		nohup ./node6.sh &> data/n6.log &
		nohup ./node7.sh &> data/n7.log &
		nohup ./node8.sh &> data/n8.log &
		nohup ./node9.sh &> data/n9.log &
		nohup ./node10.sh &> data/n10.log &
		nohup ./node11.sh &> data/n11.log &
		nohup ./node12.sh &> data/n12.log &
	elif [ ${2} == "16" ];then
		nohup ./node1.sh &> data/n1.log &
		nohup ./node2.sh &> data/n2.log &
		nohup ./node3.sh &> data/n3.log &
		nohup ./node4.sh &> data/n4.log &
		nohup ./node5.sh &> data/n5.log &
		nohup ./node6.sh &> data/n6.log &
		nohup ./node7.sh &> data/n7.log &
		nohup ./node8.sh &> data/n8.log &
		nohup ./node9.sh &> data/n9.log &
		nohup ./node10.sh &> data/n10.log &
		nohup ./node11.sh &> data/n11.log &
		nohup ./node12.sh &> data/n12.log &
		nohup ./node13.sh &> data/n13.log &
		nohup ./node14.sh &> data/n14.log &
		nohup ./node15.sh &> data/n15.log &
		nohup ./node16.sh &> data/n16.log &
	elif [ ${2} == "32" ];then
		nohup ./node1.sh &> data/n1.log &
		nohup ./node2.sh &> data/n2.log &
		nohup ./node3.sh &> data/n3.log &
		nohup ./node4.sh &> data/n4.log &
		nohup ./node5.sh &> data/n5.log &
		nohup ./node6.sh &> data/n6.log &
		nohup ./node7.sh &> data/n7.log &
		nohup ./node8.sh &> data/n8.log &
		nohup ./node9.sh &> data/n9.log &
		nohup ./node10.sh &> data/n10.log &
		nohup ./node11.sh &> data/n11.log &
		nohup ./node12.sh &> data/n12.log &
		nohup ./node13.sh &> data/n13.log &
		nohup ./node14.sh &> data/n14.log &
		nohup ./node15.sh &> data/n15.log &
		nohup ./node16.sh &> data/n16.log &
		nohup ./node17.sh &> data/n17.log &
		nohup ./node18.sh &> data/n18.log &
		nohup ./node19.sh &> data/n19.log &
		nohup ./node20.sh &> data/n20.log &
		nohup ./node21.sh &> data/n21.log &
		nohup ./node22.sh &> data/n22.log &
		nohup ./node23.sh &> data/n23.log &
		nohup ./node24.sh &> data/n24.log &
		nohup ./node25.sh &> data/n25.log &
		nohup ./node26.sh &> data/n26.log &
		nohup ./node27.sh &> data/n27.log &
		nohup ./node28.sh &> data/n28.log &
		nohup ./node29.sh &> data/n29.log &
		nohup ./node30.sh &> data/n30.log &
		nohup ./node31.sh &> data/n31.log &
		nohup ./node32.sh &> data/n32.log &

	fi

elif [ ${1} == "aws" ];then	
	if [ ${2} == "4" ];then
		if [ ${3} == "1" ]; then
			nohup ./node1.sh &> data/n1.log &
		elif [ ${3} == "2" ]; then
			nohup ./node2.sh &> data/n2.log &
		elif [ ${3} == "3" ]; then
			nohup ./node3.sh &> data/n3.log &
		elif [ ${3} == "4" ]; then
			nohup ./node4.sh &> data/n4.log &
		fi
	elif [ ${2} == "8" ];then
		if [ ${3} == "1" ]; then
			nohup ./node1.sh &> data/n1.log &
		elif [ ${3} == "2" ]; then
			nohup ./node2.sh &> data/n2.log &
		elif [ ${3} == "3" ]; then
			nohup ./node3.sh &> data/n3.log &
		elif [ ${3} == "4" ]; then
			nohup ./node4.sh &> data/n4.log &
		elif [ ${3} == "5" ]; then
			nohup ./node5.sh &> data/n5.log &
		elif [ ${3} == "6" ]; then
			nohup ./node6.sh &> data/n6.log &
		elif [ ${3} == "7" ]; then
			nohup ./node7.sh &> data/n7.log &
		elif [ ${3} == "8" ]; then
			nohup ./node8.sh &> data/n8.log &
		fi
	elif [ ${2} == "12" ];then
		if [ ${3} == "1" ]; then
			nohup ./node1.sh &> data/n1.log &
		elif [ ${3} == "2" ]; then
			nohup ./node2.sh &> data/n2.log &
		elif [ ${3} == "3" ]; then
			nohup ./node3.sh &> data/n3.log &
		elif [ ${3} == "4" ]; then
			nohup ./node4.sh &> data/n4.log &
		elif [ ${3} == "5" ]; then
			nohup ./node5.sh &> data/n5.log &
		elif [ ${3} == "6" ]; then
			nohup ./node6.sh &> data/n6.log &
		elif [ ${3} == "7" ]; then
			nohup ./node7.sh &> data/n7.log &
		elif [ ${3} == "8" ]; then
			nohup ./node8.sh &> data/n8.log &
		elif [ ${3} == "9" ]; then
			nohup ./node9.sh &> data/n9.log &
		elif [ ${3} == "10" ]; then
			nohup ./node10.sh &> data/n10.log &
		elif [ ${3} == "11" ]; then
			nohup ./node11.sh &> data/n11.log &
		elif [ ${3} == "12" ]; then
			nohup ./node12.sh &> data/n12.log &
		fi
	elif [ ${2} == "16" ];then
		if [ ${3} == "1" ]; then
			nohup ./node1.sh &> data/n1.log &
		elif [ ${3} == "2" ]; then
			nohup ./node2.sh &> data/n2.log &
		elif [ ${3} == "3" ]; then
			nohup ./node3.sh &> data/n3.log &
		elif [ ${3} == "4" ]; then
			nohup ./node4.sh &> data/n4.log &
		elif [ ${3} == "5" ]; then
			nohup ./node5.sh &> data/n5.log &
		elif [ ${3} == "6" ]; then
			nohup ./node6.sh &> data/n6.log &
		elif [ ${3} == "7" ]; then
			nohup ./node7.sh &> data/n7.log &
		elif [ ${3} == "8" ]; then
			nohup ./node8.sh &> data/n8.log &
		elif [ ${3} == "9" ]; then
			nohup ./node9.sh &> data/n9.log &
		elif [ ${3} == "10" ]; then
			nohup ./node10.sh &> data/n10.log &
		elif [ ${3} == "11" ]; then
			nohup ./node11.sh &> data/n11.log &
		elif [ ${3} == "12" ]; then
			nohup ./node12.sh &> data/n12.log &
		elif [ ${3} == "13" ]; then
			nohup ./node13.sh &> data/n13.log &
		elif [ ${3} == "14" ]; then
			nohup ./node14.sh &> data/n14.log &
		elif [ ${3} == "15" ]; then
			nohup ./node15.sh &> data/n15.log &
		elif [ ${3} == "16" ]; then
			nohup ./node16.sh &> data/n16.log &
		fi
	fi
fi	

