echo "-------In init.sh--------"

rm -r ./data/node*/geth
rm -r ./data/node*/keystore
rm ./data/*.log

if [ ${1} == "4" ];then
	../build/bin/geth --datadir "data/node1" init genesis.json
	../build/bin/geth --datadir "data/node2" init genesis.json
	../build/bin/geth --datadir "data/node3" init genesis.json
	../build/bin/geth --datadir "data/node4" init genesis.json
elif [ ${1} == "8" ];then
	../build/bin/geth --datadir "data/node1" init genesis.json
	../build/bin/geth --datadir "data/node2" init genesis.json
	../build/bin/geth --datadir "data/node3" init genesis.json
	../build/bin/geth --datadir "data/node4" init genesis.json
	../build/bin/geth --datadir "data/node5" init genesis.json
	../build/bin/geth --datadir "data/node6" init genesis.json
	../build/bin/geth --datadir "data/node7" init genesis.json
	../build/bin/geth --datadir "data/node8" init genesis.json
elif [ ${1} == "12" ];then
	../build/bin/geth --datadir "data/node1" init genesis.json
	../build/bin/geth --datadir "data/node2" init genesis.json
	../build/bin/geth --datadir "data/node3" init genesis.json
	../build/bin/geth --datadir "data/node4" init genesis.json
	../build/bin/geth --datadir "data/node5" init genesis.json
	../build/bin/geth --datadir "data/node6" init genesis.json
	../build/bin/geth --datadir "data/node7" init genesis.json
	../build/bin/geth --datadir "data/node8" init genesis.json
	../build/bin/geth --datadir "data/node9" init genesis.json
	../build/bin/geth --datadir "data/node10" init genesis.json
	../build/bin/geth --datadir "data/node11" init genesis.json
	../build/bin/geth --datadir "data/node12" init genesis.json
elif [ ${1} == "16" ];then
	../build/bin/geth --datadir "data/node1" init genesis.json
	../build/bin/geth --datadir "data/node2" init genesis.json
	../build/bin/geth --datadir "data/node3" init genesis.json
	../build/bin/geth --datadir "data/node4" init genesis.json
	../build/bin/geth --datadir "data/node5" init genesis.json
	../build/bin/geth --datadir "data/node6" init genesis.json
	../build/bin/geth --datadir "data/node7" init genesis.json
	../build/bin/geth --datadir "data/node8" init genesis.json
	../build/bin/geth --datadir "data/node9" init genesis.json
	../build/bin/geth --datadir "data/node10" init genesis.json
	../build/bin/geth --datadir "data/node11" init genesis.json
	../build/bin/geth --datadir "data/node12" init genesis.json
	../build/bin/geth --datadir "data/node13" init genesis.json
	../build/bin/geth --datadir "data/node14" init genesis.json
	../build/bin/geth --datadir "data/node15" init genesis.json
	../build/bin/geth --datadir "data/node16" init genesis.json
elif [ ${1} == "32" ];then
	../build/bin/geth --datadir "data/node1" init genesis.json
	../build/bin/geth --datadir "data/node2" init genesis.json
	../build/bin/geth --datadir "data/node3" init genesis.json
	../build/bin/geth --datadir "data/node4" init genesis.json
	../build/bin/geth --datadir "data/node5" init genesis.json
	../build/bin/geth --datadir "data/node6" init genesis.json
	../build/bin/geth --datadir "data/node7" init genesis.json
	../build/bin/geth --datadir "data/node8" init genesis.json
	../build/bin/geth --datadir "data/node9" init genesis.json
	../build/bin/geth --datadir "data/node10" init genesis.json
	../build/bin/geth --datadir "data/node11" init genesis.json
	../build/bin/geth --datadir "data/node12" init genesis.json
	../build/bin/geth --datadir "data/node13" init genesis.json
	../build/bin/geth --datadir "data/node14" init genesis.json
	../build/bin/geth --datadir "data/node15" init genesis.json
	../build/bin/geth --datadir "data/node16" init genesis.json
	../build/bin/geth --datadir "data/node17" init genesis.json
	../build/bin/geth --datadir "data/node18" init genesis.json
	../build/bin/geth --datadir "data/node19" init genesis.json
	../build/bin/geth --datadir "data/node20" init genesis.json
	../build/bin/geth --datadir "data/node21" init genesis.json
	../build/bin/geth --datadir "data/node22" init genesis.json
	../build/bin/geth --datadir "data/node23" init genesis.json
	../build/bin/geth --datadir "data/node24" init genesis.json
	../build/bin/geth --datadir "data/node25" init genesis.json
	../build/bin/geth --datadir "data/node26" init genesis.json
	../build/bin/geth --datadir "data/node27" init genesis.json
	../build/bin/geth --datadir "data/node28" init genesis.json
	../build/bin/geth --datadir "data/node29" init genesis.json
	../build/bin/geth --datadir "data/node30" init genesis.json
	../build/bin/geth --datadir "data/node31" init genesis.json
	../build/bin/geth --datadir "data/node32" init genesis.json
fi	

