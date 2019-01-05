# ${1}: local/aws
# ${2}: number of nodes, 4/8/12/16
# ${3}: node index, if it's local experiment the value would be 0
# ${4}: res directry name

./blocksize-test.sh ${1} ${2} ./nodeConfig/blocksize/200to2000/600.0/genesis.json ${3}
./catTimes.sh ${2} 600.0 ${4}

