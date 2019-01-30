# -*- coding: utf-8 -*-
from sys import argv
import json
enode =[]
def main():
    ipcportnumber=1
    f = open("PublicKey1.txt")             # 返回一个文件对象
    line = f.read().splitlines()
    #print line

    x=30303
    for i in line:
        enode.append(str("enode://"+str(i)+"@[::]:"+str(x)))
        x+=1
    print enode
    with open('nodeConfig1/'+str(argv[1])+'nodes/static-nodes.json', 'w') as outfile:
        json.dump(enode, outfile)

main()

