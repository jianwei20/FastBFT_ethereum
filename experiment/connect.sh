#!/bin/bash
for ((i<1;i<${1};i++));
do 

echo node $i
../build/bin/geth --exec 'admin.peers.length ' attach ipc:./data1/node$i/geth.ipc
../build/bin/geth --exec 'net.peerCount' attach ipc:./data1/node$i/geth.ipc

done
