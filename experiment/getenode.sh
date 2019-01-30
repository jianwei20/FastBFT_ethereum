#!/bin/bash
rm enode.txt
echo "-------getEnode--------"

for ((i=1;i<=${1};i++));
do

../build/bin/geth --exec 'admin.nodeInfo.enode' attach ipc:./data1/node${i}/geth.ipc >> enode.txt

done

python getenode.py



