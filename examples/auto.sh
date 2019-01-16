#!/bin/bash
# $1 number of the node 
rm -rf newkey 
echo "-------run geth ---------"

for ((i<0;i<${1};i++));
do 
	echo  "$1= ${1}"
	../build/bin/geth  account new   --datadir "newkey"  --password password.txt >> Address.txt
done
echo -------chmod +x-----------
chmod -R +x newkey/keystore 

for entry in `ls newkey/keystore  $search_dir`; do
     node getPrivatekey1.js $entry
done






