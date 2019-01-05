# ${1}: local/aws
# ${2}: number of nodes, 4/8/12/16
# ${3}: index of node1 ~ node16

./stop.sh
./init.sh ${2}
rm data/node*/static-nodes.json

if [ ${1} == "local" ];then
	echo "-------In setupEnv,sh, ${1} ${2} nodes test-------"
	if [ ${2} == "4" ];then
		cp ./keys/UTC--2018-01-11T15-19-37.897561446Z--8510ef1f05fa2c0698fc1c93a4cad683465d17b5 ./data/node1/keystore
		cp ./keys/UTC--2018-01-11T15-20-14.905594216Z--5b52a95f0f47f7b58a5b4c092d12ae8953838526 ./data/node2/keystore
		cp ./keys/UTC--2018-01-11T15-20-19.976269950Z--c8d1bc936217e50d72b06b9dfc6d0006e8414d22 ./data/node3/keystore
		cp ./keys/UTC--2018-01-11T15-20-21.593534625Z--3ead0b0987220b828ec40c44ac23fbccfec9ffb4 ./data/node4/keystore
		cp ./nodeConfig/4nodes/static-nodes.json ./data/node1
		cp ./nodeConfig/4nodes/static-nodes.json ./data/node2
		cp ./nodeConfig/4nodes/static-nodes.json ./data/node3
		cp ./nodeConfig/4nodes/static-nodes.json ./data/node4
		rm node*.sh
		cp nodeConfig/4nodes/*.sh ./
	elif [ ${2} == "6" ];then
		cp ./keys/UTC--2018-01-11T15-19-37.897561446Z--8510ef1f05fa2c0698fc1c93a4cad683465d17b5 ./data/node1/keystore
		cp ./keys/UTC--2018-01-11T15-20-14.905594216Z--5b52a95f0f47f7b58a5b4c092d12ae8953838526 ./data/node2/keystore
		cp ./keys/UTC--2018-01-11T15-20-19.976269950Z--c8d1bc936217e50d72b06b9dfc6d0006e8414d22 ./data/node3/keystore
		cp ./keys/UTC--2018-01-11T15-20-21.593534625Z--3ead0b0987220b828ec40c44ac23fbccfec9ffb4 ./data/node4/keystore
		cp ./keys/UTC--2018-03-02T04-04-34.746963912Z--3aa5a8c5bc7a160c3363ebbdd9c0b5e3f6badafe ./data/node5/keystore
		cp ./keys/UTC--2018-03-02T04-04-44.116691094Z--9d2ef6da20c9f0246a226155917a28f3dd7d1433 ./data/node6/keystore
		cp ./nodeConfig/6nodes/static-nodes.json ./data/node1
		cp ./nodeConfig/6nodes/static-nodes.json ./data/node2
		cp ./nodeConfig/6nodes/static-nodes.json ./data/node3
		cp ./nodeConfig/6nodes/static-nodes.json ./data/node4
		cp ./nodeConfig/6nodes/static-nodes.json ./data/node5
		cp ./nodeConfig/6nodes/static-nodes.json ./data/node6
		rm node*.sh
		cp nodeConfig/6nodes/*.sh ./
	elif [ ${2} == "8" ];then
		cp ./keys/UTC--2018-01-11T15-19-37.897561446Z--8510ef1f05fa2c0698fc1c93a4cad683465d17b5 ./data/node1/keystore
		cp ./keys/UTC--2018-01-11T15-20-14.905594216Z--5b52a95f0f47f7b58a5b4c092d12ae8953838526 ./data/node2/keystore
		cp ./keys/UTC--2018-01-11T15-20-19.976269950Z--c8d1bc936217e50d72b06b9dfc6d0006e8414d22 ./data/node3/keystore
		cp ./keys/UTC--2018-01-11T15-20-21.593534625Z--3ead0b0987220b828ec40c44ac23fbccfec9ffb4 ./data/node4/keystore
		cp ./keys/UTC--2018-03-02T04-04-34.746963912Z--3aa5a8c5bc7a160c3363ebbdd9c0b5e3f6badafe ./data/node5/keystore
		cp ./keys/UTC--2018-03-02T04-04-44.116691094Z--9d2ef6da20c9f0246a226155917a28f3dd7d1433 ./data/node6/keystore
		cp ./keys/UTC--2018-03-02T04-04-46.460421373Z--7b009dfe9f050b72e9f42c910ae9c94bf390b4be ./data/node7/keystore
		cp ./keys/UTC--2018-03-02T04-04-48.339003631Z--59b002a654f625996d79ba85b07bdd97e091c2c5 ./data/node8/keystore
		cp ./nodeConfig/8nodes/static-nodes.json ./data/node1
		cp ./nodeConfig/8nodes/static-nodes.json ./data/node2
		cp ./nodeConfig/8nodes/static-nodes.json ./data/node3
		cp ./nodeConfig/8nodes/static-nodes.json ./data/node4
		cp ./nodeConfig/8nodes/static-nodes.json ./data/node5
		cp ./nodeConfig/8nodes/static-nodes.json ./data/node6
		cp ./nodeConfig/8nodes/static-nodes.json ./data/node7
		cp ./nodeConfig/8nodes/static-nodes.json ./data/node8
		rm node*.sh
		cp nodeConfig/8nodes/*.sh ./
	elif [ ${2} == "11" ];then
		cp ./keys/UTC--2018-01-11T15-19-37.897561446Z--8510ef1f05fa2c0698fc1c93a4cad683465d17b5 ./data/node1/keystore
		cp ./keys/UTC--2018-01-11T15-20-14.905594216Z--5b52a95f0f47f7b58a5b4c092d12ae8953838526 ./data/node2/keystore
		cp ./keys/UTC--2018-01-11T15-20-19.976269950Z--c8d1bc936217e50d72b06b9dfc6d0006e8414d22 ./data/node3/keystore
		cp ./keys/UTC--2018-01-11T15-20-21.593534625Z--3ead0b0987220b828ec40c44ac23fbccfec9ffb4 ./data/node4/keystore
		cp ./keys/UTC--2018-03-02T04-04-34.746963912Z--3aa5a8c5bc7a160c3363ebbdd9c0b5e3f6badafe ./data/node5/keystore
		cp ./keys/UTC--2018-03-02T04-04-44.116691094Z--9d2ef6da20c9f0246a226155917a28f3dd7d1433 ./data/node6/keystore
		cp ./keys/UTC--2018-03-02T04-04-46.460421373Z--7b009dfe9f050b72e9f42c910ae9c94bf390b4be ./data/node7/keystore
		cp ./keys/UTC--2018-03-02T04-04-48.339003631Z--59b002a654f625996d79ba85b07bdd97e091c2c5 ./data/node8/keystore
		cp ./keys/UTC--2018-07-11T13-56-44.639284480Z--d11acfdd6acd4eb67f63206126405ccae02b922e ./data/node9/keystore
		cp ./keys/UTC--2018-07-11T13-56-56.095205206Z--2eb657dc98ad6957dddd1c90d35f2160ec265053 ./data/node10/keystore
		cp ./keys/UTC--2018-07-11T13-56-57.574414965Z--6ae0845898a2f6bfd5dbd2f1bfd8761ad7079269 ./data/node11/keystore
		cp ./nodeConfig/11nodes/static-nodes.json ./data/node1
		cp ./nodeConfig/11nodes/static-nodes.json ./data/node2
		cp ./nodeConfig/11nodes/static-nodes.json ./data/node3
		cp ./nodeConfig/11nodes/static-nodes.json ./data/node4
		cp ./nodeConfig/11nodes/static-nodes.json ./data/node5
		cp ./nodeConfig/11nodes/static-nodes.json ./data/node6
		cp ./nodeConfig/11nodes/static-nodes.json ./data/node7
		cp ./nodeConfig/11nodes/static-nodes.json ./data/node8
		cp ./nodeConfig/11nodes/static-nodes.json ./data/node9
		cp ./nodeConfig/11nodes/static-nodes.json ./data/node10
		cp ./nodeConfig/11nodes/static-nodes.json ./data/node11
		rm node*.sh
		cp nodeConfig/11nodes/*.sh ./	
	elif [ ${2} == "12" ];then
		cp ./keys/UTC--2018-01-11T15-19-37.897561446Z--8510ef1f05fa2c0698fc1c93a4cad683465d17b5 ./data/node1/keystore
		cp ./keys/UTC--2018-01-11T15-20-14.905594216Z--5b52a95f0f47f7b58a5b4c092d12ae8953838526 ./data/node2/keystore
		cp ./keys/UTC--2018-01-11T15-20-19.976269950Z--c8d1bc936217e50d72b06b9dfc6d0006e8414d22 ./data/node3/keystore
		cp ./keys/UTC--2018-01-11T15-20-21.593534625Z--3ead0b0987220b828ec40c44ac23fbccfec9ffb4 ./data/node4/keystore
		cp ./keys/UTC--2018-03-02T04-04-34.746963912Z--3aa5a8c5bc7a160c3363ebbdd9c0b5e3f6badafe ./data/node5/keystore
		cp ./keys/UTC--2018-03-02T04-04-44.116691094Z--9d2ef6da20c9f0246a226155917a28f3dd7d1433 ./data/node6/keystore
		cp ./keys/UTC--2018-03-02T04-04-46.460421373Z--7b009dfe9f050b72e9f42c910ae9c94bf390b4be ./data/node7/keystore
		cp ./keys/UTC--2018-03-02T04-04-48.339003631Z--59b002a654f625996d79ba85b07bdd97e091c2c5 ./data/node8/keystore
		cp ./keys/UTC--2018-07-11T13-56-44.639284480Z--d11acfdd6acd4eb67f63206126405ccae02b922e ./data/node9/keystore
		cp ./keys/UTC--2018-07-11T13-56-56.095205206Z--2eb657dc98ad6957dddd1c90d35f2160ec265053 ./data/node10/keystore
		cp ./keys/UTC--2018-07-11T13-56-57.574414965Z--6ae0845898a2f6bfd5dbd2f1bfd8761ad7079269 ./data/node11/keystore
		cp ./keys/UTC--2018-07-11T13-56-59.014254718Z--904c978c73ccded6b1ae72e168c6771b48679187 ./data/node12/keystore
		cp ./nodeConfig/12nodes/static-nodes.json ./data/node1
		cp ./nodeConfig/12nodes/static-nodes.json ./data/node2
		cp ./nodeConfig/12nodes/static-nodes.json ./data/node3
		cp ./nodeConfig/12nodes/static-nodes.json ./data/node4
		cp ./nodeConfig/12nodes/static-nodes.json ./data/node5
		cp ./nodeConfig/12nodes/static-nodes.json ./data/node6
		cp ./nodeConfig/12nodes/static-nodes.json ./data/node7
		cp ./nodeConfig/12nodes/static-nodes.json ./data/node8
		cp ./nodeConfig/12nodes/static-nodes.json ./data/node9
		cp ./nodeConfig/12nodes/static-nodes.json ./data/node10
		cp ./nodeConfig/12nodes/static-nodes.json ./data/node11
		cp ./nodeConfig/12nodes/static-nodes.json ./data/node12
		rm node*.sh
		cp nodeConfig/12nodes/*.sh ./
	elif [ ${2} == "16" ];then
		cp ./keys/UTC--2018-01-11T15-19-37.897561446Z--8510ef1f05fa2c0698fc1c93a4cad683465d17b5 ./data/node1/keystore
		cp ./keys/UTC--2018-01-11T15-20-14.905594216Z--5b52a95f0f47f7b58a5b4c092d12ae8953838526 ./data/node2/keystore
		cp ./keys/UTC--2018-01-11T15-20-19.976269950Z--c8d1bc936217e50d72b06b9dfc6d0006e8414d22 ./data/node3/keystore
		cp ./keys/UTC--2018-01-11T15-20-21.593534625Z--3ead0b0987220b828ec40c44ac23fbccfec9ffb4 ./data/node4/keystore
		cp ./keys/UTC--2018-03-02T04-04-34.746963912Z--3aa5a8c5bc7a160c3363ebbdd9c0b5e3f6badafe ./data/node5/keystore
		cp ./keys/UTC--2018-03-02T04-04-44.116691094Z--9d2ef6da20c9f0246a226155917a28f3dd7d1433 ./data/node6/keystore
		cp ./keys/UTC--2018-03-02T04-04-46.460421373Z--7b009dfe9f050b72e9f42c910ae9c94bf390b4be ./data/node7/keystore
		cp ./keys/UTC--2018-03-02T04-04-48.339003631Z--59b002a654f625996d79ba85b07bdd97e091c2c5 ./data/node8/keystore
		cp ./keys/UTC--2018-07-11T13-56-44.639284480Z--d11acfdd6acd4eb67f63206126405ccae02b922e ./data/node9/keystore
		cp ./keys/UTC--2018-07-11T13-56-56.095205206Z--2eb657dc98ad6957dddd1c90d35f2160ec265053 ./data/node10/keystore
		cp ./keys/UTC--2018-07-11T13-56-57.574414965Z--6ae0845898a2f6bfd5dbd2f1bfd8761ad7079269 ./data/node11/keystore
		cp ./keys/UTC--2018-07-11T13-56-59.014254718Z--904c978c73ccded6b1ae72e168c6771b48679187 ./data/node12/keystore
		cp ./keys/UTC--2018-07-11T13-57-02.558271931Z--a26e9c30fa84e7cb8a4c376a5c7c5a262d2e3d1c ./data/node13/keystore
		cp ./keys/UTC--2018-07-11T13-57-04.062422840Z--42a012c7b19cf82eb91da0f3821df66b6bb3b5eb ./data/node14/keystore
		cp ./keys/UTC--2018-07-11T13-57-05.526312874Z--fa4b6e66b6de8a16f91340bb3f46bb264ca9ce56 ./data/node15/keystore
		cp ./keys/UTC--2018-07-11T13-57-06.981311435Z--eb0766de01282407a4cf182a33dbb8d2747dc553 ./data/node16/keystore
		cp ./nodeConfig/16nodes/static-nodes.json ./data/node1
		cp ./nodeConfig/16nodes/static-nodes.json ./data/node2
		cp ./nodeConfig/16nodes/static-nodes.json ./data/node3
		cp ./nodeConfig/16nodes/static-nodes.json ./data/node4
		cp ./nodeConfig/16nodes/static-nodes.json ./data/node5
		cp ./nodeConfig/16nodes/static-nodes.json ./data/node6
		cp ./nodeConfig/16nodes/static-nodes.json ./data/node7
		cp ./nodeConfig/16nodes/static-nodes.json ./data/node8
		cp ./nodeConfig/16nodes/static-nodes.json ./data/node9
		cp ./nodeConfig/16nodes/static-nodes.json ./data/node10
		cp ./nodeConfig/16nodes/static-nodes.json ./data/node11
		cp ./nodeConfig/16nodes/static-nodes.json ./data/node12
		cp ./nodeConfig/16nodes/static-nodes.json ./data/node13
		cp ./nodeConfig/16nodes/static-nodes.json ./data/node14
		cp ./nodeConfig/16nodes/static-nodes.json ./data/node15
		cp ./nodeConfig/16nodes/static-nodes.json ./data/node16
		rm node*.sh
		cp nodeConfig/16nodes/*.sh ./
	fi

elif [ ${1} == "aws" ];then
	echo "-------In setupEnv.sh, ${1} ${2} nodes test-------"
	if [ ${2} == "4" ];then
		if [ ${3} == "1" ]; then
			cp ./keys/UTC--2018-01-11T15-19-37.897561446Z--8510ef1f05fa2c0698fc1c93a4cad683465d17b5 ./data/node1/keystore
			cp ./nodeConfig/aws/4nodes/static-nodes.json ./data/node1
		elif [ ${3} == "2" ]; then
			cp ./keys/UTC--2018-01-11T15-20-14.905594216Z--5b52a95f0f47f7b58a5b4c092d12ae8953838526 ./data/node2/keystore
			cp ./nodeConfig/aws/4nodes/static-nodes.json ./data/node2
		elif [ ${3} == "3" ]; then
			cp ./keys/UTC--2018-01-11T15-20-19.976269950Z--c8d1bc936217e50d72b06b9dfc6d0006e8414d22 ./data/node3/keystore
			cp ./nodeConfig/aws/4nodes/static-nodes.json ./data/node3
		elif [ ${3} == "4" ]; then
			cp ./keys/UTC--2018-01-11T15-20-21.593534625Z--3ead0b0987220b828ec40c44ac23fbccfec9ffb4 ./data/node4/keystore
			cp ./nodeConfig/aws/4nodes/static-nodes.json ./data/node4
		fi
		rm node*.sh
		cp nodeConfig/aws/4nodes/*.sh ./
	elif [ ${2} == "8" ];then
		if [ ${3} == "1" ]; then
			cp ./keys/UTC--2018-01-11T15-19-37.897561446Z--8510ef1f05fa2c0698fc1c93a4cad683465d17b5 ./data/node1/keystore
			cp ./nodeConfig/aws/8nodes/static-nodes.json ./data/node1
		elif [ ${3} == "2" ]; then
			cp ./keys/UTC--2018-01-11T15-20-14.905594216Z--5b52a95f0f47f7b58a5b4c092d12ae8953838526 ./data/node2/keystore
			cp ./nodeConfig/aws/8nodes/static-nodes.json ./data/node2
		elif [ ${3} == "3" ]; then
			cp ./keys/UTC--2018-01-11T15-20-19.976269950Z--c8d1bc936217e50d72b06b9dfc6d0006e8414d22 ./data/node3/keystore
			cp ./nodeConfig/aws/8nodes/static-nodes.json ./data/node3
		elif [ ${3} == "4" ]; then
			cp ./keys/UTC--2018-01-11T15-20-21.593534625Z--3ead0b0987220b828ec40c44ac23fbccfec9ffb4 ./data/node4/keystore
			cp ./nodeConfig/aws/8nodes/static-nodes.json ./data/node4
		elif [ ${3} == "5" ]; then
			cp ./keys/UTC--2018-03-02T04-04-34.746963912Z--3aa5a8c5bc7a160c3363ebbdd9c0b5e3f6badafe ./data/node5/keystore
			cp ./nodeConfig/aws/8nodes/static-nodes.json ./data/node5
		elif [ ${3} == "6" ]; then
			cp ./keys/UTC--2018-03-02T04-04-44.116691094Z--9d2ef6da20c9f0246a226155917a28f3dd7d1433 ./data/node6/keystore
			cp ./nodeConfig/aws/8nodes/static-nodes.json ./data/node6
		elif [ ${3} == "7" ]; then
			cp ./keys/UTC--2018-03-02T04-04-46.460421373Z--7b009dfe9f050b72e9f42c910ae9c94bf390b4be ./data/node7/keystore
			cp ./nodeConfig/aws/8nodes/static-nodes.json ./data/node7
		elif [ ${3} == "8" ]; then
			cp ./keys/UTC--2018-03-02T04-04-48.339003631Z--59b002a654f625996d79ba85b07bdd97e091c2c5 ./data/node8/keystore
			cp ./nodeConfig/aws/8nodes/static-nodes.json ./data/node8
		fi
		rm node*.sh
		cp nodeConfig/aws/8nodes/*.sh ./
	elif [ ${2} == "12" ];then
		if [ ${3} == "1" ]; then
			cp ./keys/UTC--2018-01-11T15-19-37.897561446Z--8510ef1f05fa2c0698fc1c93a4cad683465d17b5 ./data/node1/keystore
			cp ./nodeConfig/aws/12nodes/static-nodes.json ./data/node1
		elif [ ${3} == "2" ]; then
			cp ./keys/UTC--2018-01-11T15-20-14.905594216Z--5b52a95f0f47f7b58a5b4c092d12ae8953838526 ./data/node2/keystore
			cp ./nodeConfig/aws/12nodes/static-nodes.json ./data/node2
		elif [ ${3} == "3" ]; then
			cp ./keys/UTC--2018-01-11T15-20-19.976269950Z--c8d1bc936217e50d72b06b9dfc6d0006e8414d22 ./data/node3/keystore
			cp ./nodeConfig/aws/12nodes/static-nodes.json ./data/node3
		elif [ ${3} == "4" ]; then
			cp ./keys/UTC--2018-01-11T15-20-21.593534625Z--3ead0b0987220b828ec40c44ac23fbccfec9ffb4 ./data/node4/keystore
			cp ./nodeConfig/aws/12nodes/static-nodes.json ./data/node4
		elif [ ${3} == "5" ]; then
			cp ./keys/UTC--2018-03-02T04-04-34.746963912Z--3aa5a8c5bc7a160c3363ebbdd9c0b5e3f6badafe ./data/node5/keystore
			cp ./nodeConfig/aws/12nodes/static-nodes.json ./data/node5
		elif [ ${3} == "6" ]; then
			cp ./keys/UTC--2018-03-02T04-04-44.116691094Z--9d2ef6da20c9f0246a226155917a28f3dd7d1433 ./data/node6/keystore
			cp ./nodeConfig/aws/12nodes/static-nodes.json ./data/node6
		elif [ ${3} == "7" ]; then
			cp ./keys/UTC--2018-03-02T04-04-46.460421373Z--7b009dfe9f050b72e9f42c910ae9c94bf390b4be ./data/node7/keystore
			cp ./nodeConfig/aws/12nodes/static-nodes.json ./data/node7
		elif [ ${3} == "8" ]; then
			cp ./keys/UTC--2018-03-02T04-04-48.339003631Z--59b002a654f625996d79ba85b07bdd97e091c2c5 ./data/node8/keystore
			cp ./nodeConfig/aws/12nodes/static-nodes.json ./data/node8
		elif [ ${3} == "9" ]; then
			cp ./keys/UTC--2018-07-11T13-56-44.639284480Z--d11acfdd6acd4eb67f63206126405ccae02b922e ./data/node9/keystore
			cp ./nodeConfig/aws/12nodes/static-nodes.json ./data/node9
		elif [ ${3} == "10" ]; then
			cp ./keys/UTC--2018-07-11T13-56-56.095205206Z--2eb657dc98ad6957dddd1c90d35f2160ec265053 ./data/node10/keystore
			cp ./nodeConfig/aws/12nodes/static-nodes.json ./data/node10
		elif [ ${3} == "11" ]; then
			cp ./keys/UTC--2018-07-11T13-56-57.574414965Z--6ae0845898a2f6bfd5dbd2f1bfd8761ad7079269 ./data/node11/keystore
			cp ./nodeConfig/aws/12nodes/static-nodes.json ./data/node12
		elif [ ${3} == "12" ]; then
			cp ./keys/UTC--2018-07-11T13-56-59.014254718Z--904c978c73ccded6b1ae72e168c6771b48679187 ./data/node12/keystore
			cp ./nodeConfig/aws/12nodes/static-nodes.json ./data/node11
		fi
		rm node*.sh
		cp nodeConfig/aws/12nodes/*.sh ./
	elif [ ${2} == "16" ];then
		if [ ${3} == "1" ]; then
			cp ./keys/UTC--2018-01-11T15-19-37.897561446Z--8510ef1f05fa2c0698fc1c93a4cad683465d17b5 ./data/node1/keystore
			cp ./nodeConfig/aws/16nodes/static-nodes.json ./data/node1
		elif [ ${3} == "2" ]; then
			cp ./keys/UTC--2018-01-11T15-20-14.905594216Z--5b52a95f0f47f7b58a5b4c092d12ae8953838526 ./data/node2/keystore
			cp ./nodeConfig/aws/16nodes/static-nodes.json ./data/node2
		elif [ ${3} == "3" ]; then
			cp ./keys/UTC--2018-01-11T15-20-19.976269950Z--c8d1bc936217e50d72b06b9dfc6d0006e8414d22 ./data/node3/keystore
			cp ./nodeConfig/aws/16nodes/static-nodes.json ./data/node3
		elif [ ${3} == "4" ]; then
			cp ./keys/UTC--2018-01-11T15-20-21.593534625Z--3ead0b0987220b828ec40c44ac23fbccfec9ffb4 ./data/node4/keystore
			cp ./nodeConfig/aws/16nodes/static-nodes.json ./data/node4
		elif [ ${3} == "5" ]; then
			cp ./keys/UTC--2018-03-02T04-04-34.746963912Z--3aa5a8c5bc7a160c3363ebbdd9c0b5e3f6badafe ./data/node5/keystore
			cp ./nodeConfig/aws/16nodes/static-nodes.json ./data/node5
		elif [ ${3} == "6" ]; then
			cp ./keys/UTC--2018-03-02T04-04-44.116691094Z--9d2ef6da20c9f0246a226155917a28f3dd7d1433 ./data/node6/keystore
			cp ./nodeConfig/aws/16nodes/static-nodes.json ./data/node6
		elif [ ${3} == "7" ]; then
			cp ./keys/UTC--2018-03-02T04-04-46.460421373Z--7b009dfe9f050b72e9f42c910ae9c94bf390b4be ./data/node7/keystore
			cp ./nodeConfig/aws/16nodes/static-nodes.json ./data/node7
		elif [ ${3} == "8" ]; then
			cp ./keys/UTC--2018-03-02T04-04-48.339003631Z--59b002a654f625996d79ba85b07bdd97e091c2c5 ./data/node8/keystore
			cp ./nodeConfig/aws/16nodes/static-nodes.json ./data/node8
		elif [ ${3} == "9" ]; then
			cp ./keys/UTC--2018-07-11T13-56-44.639284480Z--d11acfdd6acd4eb67f63206126405ccae02b922e ./data/node9/keystore
			cp ./nodeConfig/aws/16nodes/static-nodes.json ./data/node9
		elif [ ${3} == "10" ]; then
			cp ./keys/UTC--2018-07-11T13-56-56.095205206Z--2eb657dc98ad6957dddd1c90d35f2160ec265053 ./data/node10/keystore
			cp ./nodeConfig/aws/16nodes/static-nodes.json ./data/node10
		elif [ ${3} == "11" ]; then
			cp ./keys/UTC--2018-07-11T13-56-57.574414965Z--6ae0845898a2f6bfd5dbd2f1bfd8761ad7079269 ./data/node11/keystore
			cp ./nodeConfig/aws/16nodes/static-nodes.json ./data/node12
		elif [ ${3} == "12" ]; then
			cp ./keys/UTC--2018-07-11T13-56-59.014254718Z--904c978c73ccded6b1ae72e168c6771b48679187 ./data/node12/keystore
			cp ./nodeConfig/aws/16nodes/static-nodes.json ./data/node11
		elif [ ${3} == "13" ]; then
			cp ./keys/UTC--2018-07-11T13-57-02.558271931Z--a26e9c30fa84e7cb8a4c376a5c7c5a262d2e3d1c ./data/node13/keystore
			cp ./nodeConfig/aws/16nodes/static-nodes.json ./data/node13
		elif [ ${3} == "14" ]; then
			cp ./keys/UTC--2018-07-11T13-57-04.062422840Z--42a012c7b19cf82eb91da0f3821df66b6bb3b5eb ./data/node14/keystore
			cp ./nodeConfig/aws/16nodes/static-nodes.json ./data/node14
		elif [ ${3} == "15" ]; then
			cp ./keys/UTC--2018-07-11T13-57-05.526312874Z--fa4b6e66b6de8a16f91340bb3f46bb264ca9ce56 ./data/node15/keystore
			cp ./nodeConfig/aws/16nodes/static-nodes.json ./data/node15
		elif [ ${3} == "16" ]; then
			cp ./keys/UTC--2018-07-11T13-57-06.981311435Z--eb0766de01282407a4cf182a33dbb8d2747dc553 ./data/node16/keystore
			cp ./nodeConfig/aws/16nodes/static-nodes.json ./data/node16
		fi
		rm node*.sh
		cp nodeConfig/aws/16nodes/*.sh ./
	fi
fi

./start.sh ${1} ${2} ${3}
sleep 10;

