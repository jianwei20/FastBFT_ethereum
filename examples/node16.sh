../build/bin/geth \
\
--networkid 2234 \
--port 30318 \
--rpcport 8560 \
--datadir "data/node16" \
--nodiscover \
\
--rpc \
--rpccorsdomain "*" \
--rpcapi "eth,net,debug" \
\
--bft \
--allow-empty \
--num-validators 16 \
--node-num 15
