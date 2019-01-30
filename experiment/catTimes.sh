# ${1}: node numbers
# ${2}: blocksize
# ${3}: fileName

for ((j=1; j<${1}+1; j++));
	do
		mkdir -p ./results/${3}/${2}-${1}node/
		cat data/n$j.log|grep StartConsensus > ./results/${3}/${2}-${1}node/StartConNode$j-${2}-${1}node.csv
		cat data/n$j.log|grep ConsensusTime > ./results/${3}/${2}-${1}node/ConsensusTimeNode$j-${2}-${1}node.csv
		cat data/n$j.log|grep Sealing > ./results/${3}/${2}-${1}node/Sealing$j-${2}-${1}node.csv
	done

mkdir ./results/${3}/${2}-${1}node/logs/
cp ./data/*.log ./results/${3}/${2}-${1}node/logs/
