#!/usr/bin/env python3
from pprint import pprint
import sys
import csv
import time

def readCsvHeader(pathFileName):
    with open(pathFileName, 'r', newline='') as csvFile:
        csvReader = csv.reader(csvFile)
        for row in csvReader:
            return row

def readResults(fileName, path="./"):
    with open (path+fileName, 'r') as file:
        Lst = [ line.strip() for line in file ]
    resultLst = filterLst([ Lst[0], Lst[-1] ])
    return resultLst, len(Lst)

def writeResults(txs,realtxs, latency, fileName, path='./'):
    header = ['blocksize', 'avgTxs', 'latency']
    with open(path+fileName, 'a', newline='') as csvFile:
        csvWriter = csv.writer(csvFile)
        first = readCsvHeader(path+fileName)
        if not first == header:
            csvWriter.writerow(header)
        csvWriter.writerow([txs, realtxs, latency])

def readConsensus(fileName, path='./'):
    timeLst = []
    txsLst = []
    with open (path+fileName, 'r') as file:
        for line in file:
            lineLst = line.split()
            timeLst.append(int(lineLst[1]))
            if len(lineLst) == 4:
                txsLst.append(int(lineLst[3]))
    return sum(timeLst), txsLst

def filterLst(consensusTimeLst):
    # filtering the input list with time info. left
    Lst = []
    for i in range(len(consensusTimeLst)):
        splitLst = consensusTimeLst[i].split()
        Lst.append(splitLst[1])
    return Lst

def calcu(timeLst, blocks):
    timeStamps = [time.mktime(time.strptime(timeLst[i], "[%m-%d|%H:%M:%S]")) for i in range(len(timeLst))]
    elapse = timeStamps[1]-timeStamps[0]
    return elapse/blocks

def floatSum(floatLst):
    j = 0
    for i in range(len(floatLst)):
        j += floatLst[i]
    return j

def main():
    txsPerBlock = sys.argv[1].split('/')

    # for consensusTime calculation
    fileNames = ['consensusTime1.txt', 'consensusTime2.txt', 'consensusTime3.txt', 'consensusTime4.txt']
    txsLst = []
    avgTime = 0
    for node in fileNames:
        time_part, txsLst_part = readConsensus(node)
        avgTime += time_part
        txsLst += txsLst_part
    avgTime /= (len(fileNames)*len(txsLst))
    avgTxs = sum(txsLst)/len(txsLst)
    writeResults(txsPerBlock[4], avgTxs, avgTime, 'consensusTime.csv')
    print('size', txsPerBlock[4], 'avgTxs', avgTxs, 'consensusTime', avgTime)

    # for total time calculation
    fileNames = ['re1.txt', 're2.txt', 're3.txt', 're4.txt']
    latencys = []
    for node in fileNames:
        timeLst, blocks = readResults(node)
        latency = calcu(timeLst, blocks)
        latencys.append(latency)
    avgLatency = floatSum(latencys)/len(fileNames)
    writeResults(txsPerBlock[4], avgTxs, avgLatency, 'totalTime.csv')
    print('size',txsPerBlock[4], 'avgTxs', avgTxs,'totalTime:',avgLatency)

main()
##########################################
