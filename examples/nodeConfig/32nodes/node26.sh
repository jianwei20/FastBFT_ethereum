../build/bin/geth \
\
--networkid 2234 \
--port 30328 \
--rpcport 8570 \
--datadir "data/node26" \
--nodiscover \
\
--rpc \
--rpccorsdomain "*" \
--rpcapi "eth,net,debug" \
\
--bft \
--allow-empty \
--num-validators 32 \
--node-num 25
