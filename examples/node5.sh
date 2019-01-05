../build/bin/geth \
\
--networkid 2234 \
--port 30307 \
--rpcport 8549 \
--datadir "data/node5" \
--nodiscover \
\
--rpc \
--rpccorsdomain "*" \
--rpcapi "eth,net,debug" \
\
--bft \
--allow-empty \
--num-validators 16 \
--node-num 4
