!/bin/bash
# $1 number of the node 
rm -rf newkey
rm Address.txt
rm Key.txt
rm publicKey.txt
rm publicKey1.txt
rm sendtx.log

./stop.sh
echo "-------run geth ---------"

for ((i<0;i<${1};i++));
do 
	../build/bin/geth  account new   --datadir "newkey"  --password password.txt
done
echo "-------chmod +x-----------"
chmod -R +x newkey/keystore 

echo "-----save private key to Key.txt---"
for entry in `ls newkey/keystore  $search_dir`; do
     node getPrivatekey1.js $entry
	 echo "$entry">>publicKey.txt
done
echo "---------writegensisjson.py--------------"

python writegenesis.py


echo "---------writejson.py--------------"

python writejson.py
echo "-------go build ethclient-----------"
go build ethclient/main.go

echo "setupEnv"
./setupEnv2.sh local ${1} 0
chmod -R +x nodeConfig1/${1}nodes *

python writeStaticNodeJson.py ${1}

chmod +x start1.sh
./start1.sh local ${1} 0



sleep 20.0

echo "cp static-node.json"
./getenode.sh ${1}


for ((i=1;i<${1}+1;i++));
do 
cp -r ./static-nodes.json  ./data1/node$i
chmod -R +x ./data1/node$i/static-nodes.json
done
chmod +x sendtx1.sh

#sleep 5.0
#./sendtx1.sh local ${1}

./stop.sh


./start1.sh local ${1} 0
sleep 20.0
./sendtx.sh local ${1}
sleep 10.0

./run-miner.sh local ${1}
sleep 20.0






