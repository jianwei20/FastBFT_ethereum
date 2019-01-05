../build/bin/geth \
\
--networkid 2234 \
--port 30303 \
--rpcport 8549 \
--datadir "data/node5" \
--nodiscover \
\
--rpc \
--rpccorsdomain "*" \
--rpcapi "eth,net,debug" \
\
--bft \
--allow-empty \
--num-validators 8 \
--node-num 4
