../build/bin/geth \
\
--networkid 2234 \
--port 30329 \
--rpcport 8571 \
--datadir "data/node27" \
--nodiscover \
\
--rpc \
--rpccorsdomain "*" \
--rpcapi "eth,net,debug" \
\
--bft \
--allow-empty \
--num-validators 32 \
--node-num 26
