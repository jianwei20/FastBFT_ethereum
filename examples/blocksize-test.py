#!/usr/bin/env python3
from pprint import pprint
from os import walk, system
from sys import argv

def getGenesis(rootPath):
    Lst = [ root+'/genesis.json' for root, dirs, files in walk(rootPath) ]
    return Lst[1:]

def getTxCounts(genesisPath):
    tmpLst = genesisPath.split('/')
    return tmpLst[3]

def runDura(server, nodes, dirName):
    for node in nodes:
        system('./duration-test.sh {0} {1}'.format(server, node))
        system('./catTimes.sh {0} {1} {2}'.format(node, 1200.0, dirName))
        system('./monitor.py {0} {1}'.format(node, 1200.0))

def runEx(server, nodes, genesisLst, nodeIndex, dirName, nodeType):
    if nodeType == "normal":
        for i in range(len(genesisLst)):
            system('./blocksize-test.sh {0} {1} {2} {3} {4}'.format(server, nodes, genesisLst[i], nodeIndex, nodeType))
            runCalcu(nodes, genesisLst[i], dirName)
    elif nodeType == "byzantine":
        for i in range(len(genesisLst)):
            system('./blocksize-test.sh {0} {1} {2} {3} {4}'.format(server, nodes, genesisLst[i], nodeIndex, nodeType))
            runCalcu(nodes, genesisLst[i], dirName)

def runCalcu (nodes, blocksize, dirName):
    blockPath = blocksize.split("/")
    blocks = blockPath[-2]
    system('./catTimes.sh {0} {1} {2}'.format(nodes, blocks, dirName))
    print("./catTimes.sh")
    system('./monitor.py {0} {1}'.format(nodes, blocks))

def main():
    print(argv)
    server = argv[1] # local or aws
    dirName = argv[2]
    testType = argv[3] # blocksize or dura
    nodeIndex = argv[4] # local:0, aws:1 to 16
    nodeType = argv[5]

    rootPath = './nodeConfig/blocksize/200to2000'
    genesisLst = getGenesis(rootPath)
    nodesNum = [4,8,16]
    if testType=="blocksize":
        for nodes in nodesNum:
            runEx(server, nodes, genesisLst, nodeIndex, dirName, nodeType)
    elif testType=="dura":
        runDura(server, nodesNum, dirName)
    else:
        print(argv)

main()
#########################################################
