#!/usr/bin/env node
const Wallet = require('ethereumjs-wallet'),
 fs = require('fs');
 os = require('os');
 fWriteName = './1.readline.log';
var password = '1234'
var arv= "newkey/keystore/"+ process.argv[2]
function PrintResult(myWallet){
	console.log("----------------------------------------------------------")
	console.log("Private Key:" + myWallet.getPrivateKey().toString('hex'))
	console.log("Address:" + myWallet.getAddress().toString('hex'))
	console.log("----------------------------------------------------------")
}


const myWallet = Wallet.fromV3(fs.readFileSync(arv).toString(), password, true);
PrintResult(myWallet)


