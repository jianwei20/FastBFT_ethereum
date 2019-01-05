#!/usr/bin/env python3
from pprint import pprint
import json
import os

def saveJson(genesis, path, fileName='/genesis.json'):
    realPath = './200to2000/'+path+fileName
    if not os.path.exists(os.path.dirname(realPath)):
        try:
            os.makedirs(os.path.dirname(realPath))
        except OSError as exc:
            if exc.errno != errnoEEXIST:
                raise
    with open(realPath, 'w') as f:
        json.dump(genesis, f, indent=4)

def readJson():
    with open('./genesis.json', 'r') as f:
        genesis = json.load(f)
    return genesis

def createGenesis(genesis):
    # gas price for a tx is 21000
    for gasShift in range(int('0x401640',16), int('0x2C0F4C0',16), 4200000):
        genesis['gasLimit'] = str(hex(gasShift))
        path = str(gasShift/21000)
        saveJson(genesis, path)
    return True

genesis = readJson()
createGenesis(genesis)

##########################################
