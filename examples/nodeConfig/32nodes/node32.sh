../build/bin/geth \
\
--networkid 2234 \
--port 30334 \
--rpcport 8576 \
--datadir "data/node32" \
--nodiscover \
\
--rpc \
--rpccorsdomain "*" \
--rpcapi "eth,net,debug" \
\
--bft \
--allow-empty \
--num-validators 32 \
--node-num 31
