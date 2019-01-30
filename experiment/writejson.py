# -*- coding: utf-8 -*-
import json

data= {}
Address =[]
ipcport=[]
publicKey=[]

def main():
    ipcportnumber=1
    f = open("Address.txt")             # 返回一个文件对象
    line = f.read().splitlines()
    #print line
    f1 = open("Key.txt")
    line1 = f1.read().splitlines()
    #print line1
    for i in line:
        ipcport.append("./data1/node"+str(ipcportnumber)+"/geth.ipc")
        ipcportnumber+=1

    data={"prvKeys":line1,"remiAddr":list(reversed(line)),"ipcPort":ipcport,"txCounts":10000}

    with open('writejson.json', 'w') as outfile:
        json.dump(data, outfile)

    print data

    f2 =open("publicKey.txt")
    line2 = f2.read().splitlines()

    with open('publicKey.json', 'w') as outfile:
        json.dump(line2, outfile)







main()
