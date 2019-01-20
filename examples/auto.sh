!/bin/bash
# $1 number of the node 
rm -rf newkey
rm Address.txt
rm Key.txt
rm publicKey.txt
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
echo "---------writejson.py--------------"

python writejson.py
echo "-------go build ethclient-----------"
go build ethclient/main.go

echo "setupEnv"
./setupEnv2.sh local $1 0









