
rm ./genesis.json
cp ./nodeConfig/blocksize/472txs/genesis.json ./
echo "472txs\n" >> result.log
for ((i=0; i<5; i++));
do
	./setupEnv.sh
	echo "==================Test $i====================="
	./experiment.sh
	sleep 10.0;
	./run-miner.sh
	sleep 10.0;
	cat data/n1.log | grep "txs"
done
./calcu.py >> result.log
./stop.sh
rm ./nohup.out

rm ./genesis.json
cp ./nodeConfig/blocksize/940txs/genesis.json ./
echo "940txs\n" >> result.log
for ((i=0; i<5; i++));
do
	./setupEnv.sh
	echo "==================Test $i====================="
	./experiment.sh
	sleep 10.0;
	./run-miner.sh
	sleep 10.0;
	cat data/n1.log | grep "txs"
done
./calcu.py >> result.log
./stop.sh
rm ./nohup.out

rm ./genesis.json
cp ./nodeConfig/blocksize/1267txs/genesis.json ./
echo "1267txs\n" >> result.log
for ((i=0; i<5; i++));
do
	./setupEnv.sh
	echo "==================Test $i====================="
	./experiment.sh
	sleep 10.0;
	./run-miner.sh
	sleep 10.0;
	cat data/n1.log | grep "txs"
done
./calcu.py >> result.log
./stop.sh
rm ./nohup.out

rm ./genesis.json
echo "1815txs\n" >> result.log
cp ./nodeConfig/blocksize/1815txs/genesis.json ./
for ((i=0; i<5; i++));
do
	./setupEnv.sh
	echo "==================Test $i====================="
	./experiment.sh
	sleep 10.0;
	./run-miner.sh
	sleep 10.0;
	cat data/n1.log | grep "txs"
done
./calcu.py >> result.log
./stop.sh
rm ./nohup.out

rm ./genesis.json
echo "2400txs\n" >> result.log
cp ./nodeConfig/blocksize/2400txs/genesis.json ./
for ((i=0; i<5; i++));
do
	./setupEnv.sh
	echo "==================Test $i====================="
	./experiment.sh
	sleep 10.0;
	./run-miner.sh
	sleep 10.0;
	cat data/n1.log | grep "txs"
done
./calcu.py >> result.log
./stop.sh
rm ./nohup.out

rm ./genesis.json
cp ./nodeConfig/blocksize/2611txs/genesis.json ./
echo "2611txs\n" >> result.log
for ((i=0; i<5; i++));
do
	./setupEnv.sh
	echo "==================Test $i====================="
	./experiment.sh
	sleep 10.0;
	./run-miner.sh
	sleep 10.0;
	cat data/n1.log | grep "txs"
done
./calcu.py >> result.log
./stop.sh
rm ./nohup.out

rm ./genesis.json
cp ./nodeConfig/blocksize/3408txs/genesis.json ./
echo "3408txs\n" >> result.log
for ((i=0; i<5; i++));
do
	./setupEnv.sh
	echo "==================Test $i====================="
	./experiment.sh
	sleep 10.0;
	./run-miner.sh
	sleep 10.0;
	cat data/n1.log | grep "txs"
done
./calcu.py >> result.log
./stop.sh
rm ./nohup.out

rm ./genesis.json
cp ./nodeConfig/blocksize/5200txs/genesis.json ./
echo "5200txs\n" >> result.log
for ((i=0; i<5; i++));
do
	./setupEnv.sh
	echo "==================Test $i====================="
	./experiment.sh
	sleep 10.0;
	./run-miner.sh
	sleep 10.0;
	cat data/n1.log | grep "txs"
done
./calcu.py >> result.log
./stop.sh
rm ./nohup.out

rm ./genesis.json
cp ./nodeConfig/blocksize/6800txs/genesis.json ./
echo "6800txs\n" >> result.log
for ((i=0; i<5; i++));
do
	./setupEnv.sh
	echo "==================Test $i====================="
	./experiment.sh
	sleep 10.0;
	./run-miner.sh
	sleep 10.0;
	cat data/n1.log | grep "txs"
done
./calcu.py >> result.log
./stop.sh
rm ./nohup.out

