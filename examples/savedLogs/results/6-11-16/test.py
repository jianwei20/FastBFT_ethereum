# -*- coding: utf-8 -*-

#!/usr/bin/env python3
import pandas as pd
import numpy as np
import os

# blocksize test table
b_header = ["nodeNum", "nodeIndex", "blocksize", "TotalHeights", "Throughput", "Overhead", "Latency"]
bsTable = np.zeros([400, len(b_header)])

def makeTable(header, blocksize, nodeNum, rawConTimePath, rawStartConPath, fileName):
    try:
        rawConTime = pd.read_csv(rawConTimePath, header=None)
        rawStartCon = pd.read_csv(rawStartConPath, header=None)
    except:
        print("rawConTimePath", rawConTimePath, "rawStartConPath", rawStartConPath)
    arr = np.zeros([rawConTime.shape[0]+1,len(header)])
    for i in range(1, rawConTime.shape[0]+1):
        try:
            arr[i-1][0] = i #Height
            arr[i-1][1] = rawConTime.loc[i-1,1]  #ConTime
            #arr[i-1][2] = rawConTime.loc[i-1,3] #Txs
            arr[i-1][3] = (rawStartCon.loc[i,1]-rawStartCon.loc[i-1,1])/(10**6) #TotalTime
            #arr[i-1][4] = arr[i-1][3]-arr[i-1][1] #NonConTime
        except KeyError as k:
            print(k, "index:", i)
            continue
    heights = rawStartCon.shape[0]-1
    totalTime = (rawStartCon.loc[heights,1]-rawStartCon.loc[0,1])
    throughput = ((blocksize+20)*heights)/(rawStartCon.loc[heights,1]-rawStartCon.loc[0,1])*(10**9)
    latency = (rawStartCon.loc[heights,1]-rawStartCon.loc[0,1])/(heights)/(10**9)
    #arr[0][5] = (rawConTime[3].sum())/(rawStartCon.loc[rawStartCon.shape[0]-1,1]-rawStartCon.loc[0,1])*(10**9) #throughput
    arr[0][5] = throughput
    arr[0][7] = latency
    res_df = pd.DataFrame(arr,columns=header)
    res_df.to_csv(fileName)
    print("blocksize:{0},nodeNum:{1},height:{2},throughput{3},latency:{4}".format(blocksize,nodeNum,heights,throughput,latency))
    overhead = (totalTime - (res_df["ConTime"].sum()))/totalTime
    return [heights, throughput, overhead, latency]

def runCalcu(header):
    i = 0
    for nodeNum in range(6,20,5):
        for blocksize in range(200,2200,200):
            for nodeIndex in range(1,nodeNum+1):
                rawConTimePath = ("./{1}.0-{0}node/ConsensusTimeNode{2}-{1}.0-{0}node.csv".format(nodeNum, blocksize, nodeIndex))
                rawStartConPath = ("./{1}.0-{0}node/StartConNode{2}-{1}.0-{0}node.csv".format(nodeNum, blocksize, nodeIndex))
                pathName = ("./{1}.0-{0}node/node{2}.csv".format(nodeNum, blocksize, nodeIndex))
                Lst = makeTable(header, blocksize, nodeNum,rawConTimePath, rawStartConPath, pathName)
                bsTable[i][0] = nodeNum
                bsTable[i][1] = nodeIndex
                bsTable[i][2] = blocksize
                bsTable[i][3] = Lst[0]
                bsTable[i][4] = Lst[1]
                bsTable[i][5] = Lst[2]
                bsTable[i][6] = Lst[3]
                i += 1

def main():
    header = ["Height","ConTime","Txs","TotalTime","NonConTime","Throughput","Overhead","Latency"]
    runCalcu(header)
    bs_df = pd.DataFrame(bsTable, columns=b_header)
    bs_df.to_csv("./summary.csv")
main()
#########################################


