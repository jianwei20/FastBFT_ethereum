../build/bin/geth --exec 'admin.peers.length ' attach ipc:./data1/node1/geth.ipc
../build/bin/geth --exec 'net.listening' attach ipc:./data1/node1/geth.ipc
../build/bin/geth --exec 'admin.nodeInfo' attach ipc:./data1/node1/geth.ipc
