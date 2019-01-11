../build/bin/geth \
\
--networkid 2234 \
--port 30322 \
--rpcport 8564 \
--datadir "data/node20" \
--nodiscover \
\
--rpc \
--rpccorsdomain "*" \
--rpcapi "eth,net,debug" \
\
--bft \
--allow-empty \
--num-validators 32 \
--node-num 19
