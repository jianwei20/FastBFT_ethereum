# ${1}: local/aws
# ${2}: number of nodes, 4/8/12/16
# ${3}: path of genesis file
# ${4}: node index, if it's local experiment the value would be 0
# ${5}: node type, normal/byz

rm ./genesis.json
#cp ./nodeConfig/blocksize/472txs/genesis.json ./
cp ${3} ./

if [ ${5} == "normal" ];then
	./setupEnv.sh ${1} ${2} ${4}
	sleep 5.0 # wait for the ipc port setup, otherwise may get connection refuse
	./sendtx.sh ${1} ${2} ${4}
	sleep 120.0
	./run-miner.sh ${1} ${2} ${4}
	sleep 3.0

elif [ ${5} == "byzantine" ];then
	./setupEnv.sh ${1} ${2} ${4}
	sleep 150.0
fi

#./stop.sh
echo "~~~~~take a break~~~~~"
