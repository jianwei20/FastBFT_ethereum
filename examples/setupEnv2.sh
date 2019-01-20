#!/bin/bash

# ${1}: local/aws
# ${2}: number of nodes, 4/8/12/16
# ${3}: index of node1 ~ node16

./stop.sh
./init1.sh ${2}
rm -rf nodeConfig1/${2}nodes
mkdir nodeConfig1/${2}nodes
rm data1/node*/static-nodes.json


python writeNodeShell.py ${2}

x=1
for entry in `ls newkey/keystore  $search_dir`; do
echo "save ${entry} to node ${x}"
cp ./newkey/keystore/${entry}  ./data1/node${x}/keystore

x=$((x+1))
done 

rm node*.sh
cp nodeConfig1/${2}nodes/*.sh ./

