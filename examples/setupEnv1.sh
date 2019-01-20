#!/bin/bash

./stop.sh
./init1.sh ${2}
rm data/node*/static-nodes.json


echo "--------aaaaa--------"
x = 1
#for entry in `ls newkey/keystore  $search_dir`; do
	#echo " ${entry}"	
	#cp ./newkey/keystore/${entry} ./data1/node${a}/keystore
	echo $x
  #  x=$(($x+1))
#done 

echo "-----------bbbbbb-------------"




#if [ ${1} == "local" ];then
#	echo "-------In setupEnv1,sh, ${1} ${2} nodes test-------"
#for ((i=1;i<=${2};i++));
#do
# cp ./keys/UTC--2018-01-11T15-19-37.897561446Z--8510ef1f05fa2c0698fc1c93a4cad683465d17b5 ./data/node${i}/keystore
#cp ./nodeConfig/4nodes/static-nodes.json ./data/node1

#rm node*.sh
#cp nodeConfig/4nodes/*.sh ./
#done
