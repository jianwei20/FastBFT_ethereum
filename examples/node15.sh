../build/bin/geth \
\
--networkid 2234 \
--port 30317 \
--rpcport 8559 \
--datadir "data/node15" \
--nodiscover \
\
--rpc \
--rpccorsdomain "*" \
--rpcapi "eth,net,debug" \
\
--bft \
--allow-empty \
--num-validators 16 \
--node-num 14
