# -*- coding: utf-8 -*-
import json


def main():
    ipcportnumber=1
    my_list=[]
    for line in open("enode.txt"):
        print line.strip('\n').lstrip('"').strip('"')
        my_list.append(line.strip('\n').lstrip('"').strip('"'))
    print my_list



    with open('static-nodes.json', 'w') as outfile:
        json.dump((my_list), outfile)

main()
