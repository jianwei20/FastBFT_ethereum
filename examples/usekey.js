var keythereum = require("keythereum");
var datadir = "./key1s";
var address = "fdbed5e3ed0d7d46165b216215fc680f04ef36ee";

var keyObject = keythereum.importFromFile(address, datadir);
var privateKey = keythereum.recover(1234, keyObject);
console.log(privateKey.toString('hex'));
