../build/bin/geth \
\
--networkid 2234 \
--port 30326 \
--rpcport 8568 \
--datadir "data/node24" \
--nodiscover \
\
--rpc \
--rpccorsdomain "*" \
--rpcapi "eth,net,debug" \
\
--bft \
--allow-empty \
--num-validators 32 \
--node-num 23
