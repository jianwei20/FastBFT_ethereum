../build/bin/geth \
\
--networkid 2234 \
--port 30313 \
--rpcport 8555 \
--datadir "data/node11" \
--nodiscover \
\
--rpc \
--rpccorsdomain "*" \
--rpcapi "eth,net,debug" \
\
--bft \
--allow-empty \
--num-validators 16 \
--node-num 10
