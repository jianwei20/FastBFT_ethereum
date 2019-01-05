# ${1}: node index

../build/bin/geth --exec 'admin.peers' attach ipc:./data/node${1}/geth.ipc
