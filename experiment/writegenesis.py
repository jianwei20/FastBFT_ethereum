# -*- coding: utf-8 -*-
import json
import sys


genesisjson={
    "nonce": "0x0",
    "gasLimit": "0x401640",
    "alloc": {
            "0000000000000000000000000000000000000065": {"balance": "0x1"},
            "0000000000000000000000000000000000000025": {"balance": "0x1"}
    },
    "coinbase": "0x0000000000000000000000000000000000000000",
    "difficulty": "0x100000",
    "extraData": "0x0000000000000000000000000000000000000000000000000000000000000000",
    "mixHash": "0x0000000000000000000000000000000000000000000000000000000000000000",
    "config": {
        "eip155Block": 3,
        "chainId": 2235,
        "ethash": {},
        "eip150Block": 2,
        "homesteadBlock": 1,
        "eip158Block": 3,
        "eip150Hash": "0x0000000000000000000000000000000000000000000000000000000000000000"
    },
    "parentHash": "0x0000000000000000000000000000000000000000000000000000000000000000",
    "timestamp": "0x592d25a6"
}



def main():
  with open('genesis.json', 'r') as f:
    data = json.load(f)
    #print line

    #print data['alloc']

    f = open("Address.txt")             # 返回一个文件对象
    line = f.read().splitlines()
    test=line
    primes = [2, 3, 5, 7]
    for i in test:
        print i
        genesisjson["alloc"][i[2:]] = {"balance": "1000000000000000000000"}

        #genesisjson["alloc"]+={i[2:]:{"balance": "0x1"}

    print 'bloclsize::',sys.argv[1]
    genesisjson["gasLimit"]=str(hex(int(sys.argv[1])*21000))
    print genesisjson
    with open('genesis.json', 'w') as outfile:
        json.dump(genesisjson, outfile)


main()

