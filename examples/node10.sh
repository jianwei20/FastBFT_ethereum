../build/bin/geth \
\
--networkid 2234 \
--port 30312 \
--rpcport 8554 \
--datadir "data/node10" \
--nodiscover \
\
--rpc \
--rpccorsdomain "*" \
--rpcapi "eth,net,debug" \
\
--bft \
--allow-empty \
--num-validators 16 \
--node-num 9
