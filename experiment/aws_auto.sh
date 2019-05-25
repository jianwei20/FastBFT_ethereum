#!/bin/bash
# $1 total number of the node
# $2 size of block 
# $3 number of the node in the ip
rm -rf newkey
rm Address.txt
rm Key.txt
rm publicKey.txt
rm publicKey1.txt
rm sendtx.log
rm node*.sh 
rm -rf nodeConfig1/${1}nodes
mkdir nodeConfig1/${1}nodes


./stop.sh
echo "-------run geth ---------"

for ((i<0;i<${3};i++));
do 
	../build/bin/geth  account new   --datadir "newkey"  --password password.txt
done
echo "-------chmod +x-----------"
chmod -R +x newkey/keystore 
echo "-----save private key to Key.txt---"
for entry in `ls newkey/keystore  $search_dir`; do
     /home/ubuntu/.nvm/versions/node/v12.3.1/bin/node getPrivatekey1.js $entry
	 echo "$entry">>publicKey.txt
done

