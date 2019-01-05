../build/bin/geth \
\
--networkid 2234 \
--port 30303 \
--rpcport 8551 \
--datadir "data/node7" \
--nodiscover \
\
--rpc \
--rpccorsdomain "*" \
--rpcapi "eth,net,debug" \
\
--bft \
--allow-empty \
--num-validators 16 \
--node-num 6
