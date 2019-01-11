../build/bin/geth \
\
--networkid 2234 \
--port 30325 \
--rpcport 8567 \
--datadir "data/node23" \
--nodiscover \
\
--rpc \
--rpccorsdomain "*" \
--rpcapi "eth,net,debug" \
\
--bft \
--allow-empty \
--num-validators 32 \
--node-num 22
