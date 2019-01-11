../build/bin/geth \
\
--networkid 2234 \
--port 30332 \
--rpcport 8574 \
--datadir "data/node30" \
--nodiscover \
\
--rpc \
--rpccorsdomain "*" \
--rpcapi "eth,net,debug" \
\
--bft \
--allow-empty \
--num-validators 32 \
--node-num 29
