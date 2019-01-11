../build/bin/geth \
\
--networkid 2234 \
--port 30321 \
--rpcport 8563 \
--datadir "data/node19" \
--nodiscover \
\
--rpc \
--rpccorsdomain "*" \
--rpcapi "eth,net,debug" \
\
--bft \
--allow-empty \
--num-validators 32 \
--node-num 18
