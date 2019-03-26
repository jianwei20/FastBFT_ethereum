#!/bin/bash
# ${1}: local/aws
# ${2}: number of nodes, 4/8/12/16
# ${3}: index of node1 ~ node16



#!/bin/bash
# $1 total number of the node
# $2 size of block 
# $3 number of the node in the ip

./stop.sh
./init1.sh ${3} #${2}
rm -rf nodeConfig1/${1}nodes
mkdir nodeConfig1/${1}nodes
rm data1/node*/static-nodes.json


python writeNodeShell.py ${1} ${2} ${3}

x=1
for entry in `ls newkey/keystore  $search_dir`; do
echo "save ${entry} to node ${x}"
cp ./newkey/keystore/${entry}  ./data1/node${x}/keystore

x=$((x+1))
done 

rm node*.sh
cp nodeConfig1/${2}nodes/*.sh ./


