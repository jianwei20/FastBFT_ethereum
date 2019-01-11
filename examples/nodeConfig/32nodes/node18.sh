../build/bin/geth \
\
--networkid 2234 \
--port 30320 \
--rpcport 8562 \
--datadir "data/node18" \
--nodiscover \
\
--rpc \
--rpccorsdomain "*" \
--rpcapi "eth,net,debug" \
\
--bft \
--allow-empty \
--num-validators 32 \
--node-num 17
