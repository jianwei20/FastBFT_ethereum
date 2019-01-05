../build/bin/geth \
\
--networkid 2234 \
--port 30311 \
--rpcport 8553 \
--datadir "data/node9" \
--nodiscover \
\
--rpc \
--rpccorsdomain "*" \
--rpcapi "eth,net,debug" \
\
--bft \
--allow-empty \
--num-validators 16 \
--node-num 8
