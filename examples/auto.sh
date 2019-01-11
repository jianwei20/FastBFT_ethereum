#!/bin/bash
# $1 number of the node 
echo "-------run geth ---------"

for ((i<0;i<${1};i++));
do 
	echo  "$1= ${1}"
	../build/bin/geth  account new --datadir "keys" --keystore key1s/ --password password.txt >test1.txt
done







