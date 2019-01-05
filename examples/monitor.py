#!/usr/bin/env python3
from os import system
from sys import argv

def checkLog():
    with open('./check.log', 'r') as log:
        Lst = [line for line in log]
        if not len(Lst)>10:
            return False
        else:
            return True

def main():
    system('cat ./data/n*.log|grep Sealing > check.log')
    if not checkLog():
        print("=======Error Occured, plz check saved logs=======")
        system('mkdir -p ./savedLogs/{0}nodes-{1}txs/'.format(argv[1], argv[2]))
        system('cp ./data/n*.log ./savedLogs/{0}nodes-{1}txs/'.format(argv[1], argv[2]))
    system('rm check.log')
    print(argv)

main()
