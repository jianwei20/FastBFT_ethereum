../build/bin/geth \
\
--networkid 2234 \
--port 30319 \
--rpcport 8561 \
--datadir "data/node17" \
--nodiscover \
\
--rpc \
--rpccorsdomain "*" \
--rpcapi "eth,net,debug" \
\
--bft \
--allow-empty \
--num-validators 32 \
--node-num 17
