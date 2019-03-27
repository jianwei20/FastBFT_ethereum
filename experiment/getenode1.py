# -*- coding: utf-8 -*-
import json


def main():
    ipcportnumber=1
    my_list=[]

    i=0
    for line in open("enode.txt"):
        i+=1
        if i%2==0:
            b= line.strip('\n').lstrip('"').strip('"').replace('[::]',a)
            my_list.append(b.strip('\n').lstrip('"').strip('"'))
        else:
            a= line.strip('\n').lstrip('"').strip('"')
    print my_list



    with open('static-nodes.json', 'w') as outfile:
        json.dump((my_list), outfile)

main()
