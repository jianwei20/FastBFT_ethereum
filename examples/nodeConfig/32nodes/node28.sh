../build/bin/geth \
\
--networkid 2234 \
--port 30330 \
--rpcport 8572 \
--datadir "data/node28" \
--nodiscover \
\
--rpc \
--rpccorsdomain "*" \
--rpcapi "eth,net,debug" \
\
--bft \
--allow-empty \
--num-validators 32 \
--node-num 27
