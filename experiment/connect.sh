#!/bin/bash
for ((i<0;i<${1};i++));
do 

echo node ${1}
../build/bin/geth --exec 'admin.peers.length ' attach ipc:./data1/node$i/geth.ipc
../build/bin/geth --exec 'net.peerCount' attach ipc:./data1/node$i/geth.ipc
done
