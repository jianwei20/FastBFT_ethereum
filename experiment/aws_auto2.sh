#!/bin/bash
# $1 total number of the node
# $2 size of block
# $3 number of the node in the ip
echo "------------setEnv2------------ "
./stop.sh
./init1.sh ${3}
rm data1/node*/static-nodes.json
x=1
for entry in `ls newkey/keystore  $search_dir`; do
echo "save ${entry} to node ${x}"
cp ./newkey/keystore/${entry}  ./data1/node${x}/keystore

x=$((x+1))
done


