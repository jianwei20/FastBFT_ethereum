../build/bin/geth \
\
--networkid 2234 \
--port 30333 \
--rpcport 8575 \
--datadir "data/node31" \
--nodiscover \
\
--rpc \
--rpccorsdomain "*" \
--rpcapi "eth,net,debug" \
\
--bft \
--allow-empty \
--num-validators 32 \
--node-num 30
