../build/bin/geth \
\
--networkid 2234 \
--port 30323 \
--rpcport 8565 \
--datadir "data/node21" \
--nodiscover \
\
--rpc \
--rpccorsdomain "*" \
--rpcapi "eth,net,debug" \
\
--bft \
--allow-empty \
--num-validators 32 \
--node-num 20
