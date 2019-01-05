../build/bin/geth \
\
--networkid 2234 \
--port 30308 \
--rpcport 8550 \
--datadir "data/node6" \
--nodiscover \
\
--rpc \
--rpccorsdomain "*" \
--rpcapi "eth,net,debug" \
\
--bft \
--allow-empty \
--num-validators 12 \
--node-num 5
