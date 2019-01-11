../build/bin/geth \
\
--networkid 2234 \
--port 30327 \
--rpcport 8569 \
--datadir "data/node25" \
--nodiscover \
\
--rpc \
--rpccorsdomain "*" \
--rpcapi "eth,net,debug" \
\
--bft \
--allow-empty \
--num-validators 32 \
--node-num 24