../build/bin/geth \
\
--networkid 2234 \
--port 30331 \
--rpcport 8573 \
--datadir "data/node29" \
--nodiscover \
\
--rpc \
--rpccorsdomain "*" \
--rpcapi "eth,net,debug" \
\
--bft \
--allow-empty \
--num-validators 32 \
--node-num 28
