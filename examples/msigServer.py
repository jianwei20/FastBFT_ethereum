#!/usr/bin/env python2
import socket
import threading
import pickle
from os import system

bind_ip = "0.0.0.0"
bind_port = 8787

def blocksizeTest(nodeIndex, nodeType):
    print("---in blocksizeTest---, self nodeIndex is:", nodeIndex)
    system("./blocksize-test.py {0} {1} {2} {3} {4}".format("aws", "servertest", "blocksize", int(nodeIndex), nodeType))

def setupEnv(nodeIndex):
    print("---testType:'SetupEnv'---")
    system("./setupEnv.sh {0} {1} {2}".format("aws", "16", int(nodeIndex)))
    system("../build/bin/geth --exec 'admin.peers' attach ipc:./data/node{0}/geth.ipc".format(nodeIndex))

def tmpTest(nodeIndex):
    print("---tmpTest---")
    system("./tmp-test.sh {0} {1} {2}".format("aws", "4", int(nodeIndex), "tmp4node"))
    system("./tmp-test.sh {0} {1} {2}".format("aws", "8", int(nodeIndex), "tmp8node"))

def handler(clientSocket):
    rawRequest = clientSocket.recv(1024)
    res = pickle.loads(rawRequest)
    print(res)
    print("[*] Received: test: {0}, nodeIndex: {1}".format(res["testType"], res["nodeIndex"]))
    if res["testType"]=="blocksizeTest":
        print("run bt, nodeIndex:", res["nodeIndex"])
        nodeType = 'normal'
        blocksizeTest(res["nodeIndex"], nodeType)

    elif res["testType"]=="setupEnv":
        setupEnv(res["nodeIndex"])

    elif res["testType"]=="byzantine-mode":
        nodeType = 'byzantine'
        blocksizeTest(res["nodeIndex"], nodeType)


    elif res["testType"]=="tmpTest":
        tmpTest(res["nodeIndex"])

    elif res["testType"]=="None":
        print("res:",res)

    clientSocket.send("ACK!!!")
    clientSocket.close()

def main():
    server = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    server.bind((bind_ip, bind_port))
    server.listen(5)
    print("[*] Listening on {0}:{1}".format(bind_ip, bind_port))

    while True:
        client, addr = server.accept()
        print("[*] Accepted connection from:{0}:{1}".format(addr[0], addr[1]))
        clientHandler = threading.Thread(target=handler, args=(client,))
        clientHandler.start()

main()
