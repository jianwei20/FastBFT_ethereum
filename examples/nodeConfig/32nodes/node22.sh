../build/bin/geth \
\
--networkid 2234 \
--port 30324 \
--rpcport 8566 \
--datadir "data/node22" \
--nodiscover \
\
--rpc \
--rpccorsdomain "*" \
--rpcapi "eth,net,debug" \
\
--bft \
--allow-empty \
--num-validators 32 \
--node-num 15
