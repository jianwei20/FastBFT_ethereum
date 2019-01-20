# -*- coding: utf-8 -*-
import os
import time
from sys import argv

def nsfile(s):
  '''The number of new expected documents'''
  #判断文件夹是否存在，如果不存在则创建
  b = os.path.exists("nodeConfig1/"+str(s)+"nodes")
  if b:
    print "File Exist!"
  else:
    os.mkdir("nodeConfig1/"+str(s)+"nodes")
  #生成文件
  for i in range(1,s+1):
    filename = "nodeConfig1/"+str(s)+"nodes/"+"node"+str(i)+".sh"
    #a:以追加模式打开（必要时可以创建）append;b:表示二进制
    f = open(filename,'ab')
    
    testnote = '测试文件'
    f.write(testnote)
    f.close()
    #输出第几个文件和对应的文件名称
    print filename
    time.sleep(1)
  print "ALL Down"
  time.sleep(1)

if __name__ == '__main__':
  s = int(argv[1]) # number of node 
  #s = input("请输入需要生成的文件数：")
  nsfile((s))
