../build/bin/geth \
\
--networkid 2234 \
--port 30306 \
--rpcport 8548 \
--datadir "data/node4" \
--nodiscover \
\
--rpc \
--rpccorsdomain "*" \
--rpcapi "eth,net,web3,debug" \
\
--bft \
--allow-empty \
--num-validators 12 \
--node-num 3
