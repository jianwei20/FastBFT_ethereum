../build/bin/geth \
\
--networkid 2234 \
--port 30314 \
--rpcport 8556 \
--datadir "data/node12" \
--nodiscover \
\
--rpc \
--rpccorsdomain "*" \
--rpcapi "eth,net,debug" \
\
--bft \
--allow-empty \
--num-validators 16 \
--node-num 11
