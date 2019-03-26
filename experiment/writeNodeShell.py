# -*- coding: utf-8 -*-
import os
import time
from sys import argv

def nsfile(s):
  b = os.path.exists("nodeConfig1/"+str(s)+"nodes")
  if b:
    print "File Exist!"
  else:
    os.mkdir("nodeConfig1/"+str(s)+"nodes")
  #生成文件




  k=1
  for i in range(1,s+1):
    if k<t :
      filename = "nodeConfig1/"+str(s)+"nodes/"+"node"+str(i)+".sh"
      f = open(filename,'ab')
      print("k=",k)

      testnote = '../build/bin/geth \
\
--networkid 2234 \
--port '+str(30302+k)+' \
--rpcport '+str(8544+k)+' \
--datadir "data1/node'+str(k)+'"'+' \
--nodiscover \
--rpc \
--rpccorsdomain "*" \
--rpcapi "eth,net,web3,debug" \
\
--bft \
--allow-empty \
--num-validators '+str(s)+' \
--node-num '+str(i-1)+' '

      f.write(testnote)
        k+=1
      f.close()
      print filename
      time.sleep(1)

    else:
      filename = "nodeConfig1/"+str(s)+"nodes/"+"node"+str(i)+".sh"
      f = open(filename,'ab')
      print("k=",k)
      testnote = '../build/bin/geth \
\
--networkid 2234 \
--port '+str(30302+k)+' \
--rpcport '+str(8544+k)+' \
--datadir "data1/node'+str(i)+'"'+' \
--nodiscover \
--rpc \
--rpccorsdomain "*" \
--rpcapi "eth,net,web3,debug" \
\
--bft \
--allow-empty \
--num-validators '+str(s)+' \
--node-num '+str(i-1)+' '

      f.write(testnote)
      k=1
      f.close()

      print filename
      time.sleep(1)
  print "ALL Down"
  time.sleep(1)

if __name__ == '__main__':
  s = int(argv[1]) #total number of the node
  t = int(argv[3]) #number of the node in the ip
  nsfile((s))
