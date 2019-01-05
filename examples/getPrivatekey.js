#!/usr/bin/env node

const Wallet = require('ethereumjs-wallet'),
	  fs = require('fs');

function PrintResult(myWallet){
	console.log("----------------------------------------------------------")
	console.log("Private Key:" + myWallet.getPrivateKey().toString('hex'))
	console.log("Address:" + myWallet.getAddress().toString('hex'))
	console.log("----------------------------------------------------------")
}

function ConvertKeyFile(keys, password){
	for (i=0; i<keys.length; i++) {
		const myWallet = Wallet.fromV3(fs.readFileSync(keys[i]).toString(), password, true);
		PrintResult(myWallet)
	}
}

var keys = ["./keys/UTC--2018-01-11T15-19-37.897561446Z--8510ef1f05fa2c0698fc1c93a4cad683465d17b5",
	"./keys/UTC--2018-01-11T15-20-14.905594216Z--5b52a95f0f47f7b58a5b4c092d12ae8953838526",
	"./keys/UTC--2018-01-11T15-20-19.976269950Z--c8d1bc936217e50d72b06b9dfc6d0006e8414d22",
	"./keys/UTC--2018-01-11T15-20-21.593534625Z--3ead0b0987220b828ec40c44ac23fbccfec9ffb4",
	"./keys/UTC--2018-03-02T04-04-34.746963912Z--3aa5a8c5bc7a160c3363ebbdd9c0b5e3f6badafe",
	"./keys/UTC--2018-03-02T04-04-44.116691094Z--9d2ef6da20c9f0246a226155917a28f3dd7d1433",
	"./keys/UTC--2018-03-02T04-04-46.460421373Z--7b009dfe9f050b72e9f42c910ae9c94bf390b4be",
	"./keys/UTC--2018-03-02T04-04-48.339003631Z--59b002a654f625996d79ba85b07bdd97e091c2c5",
	"./keys/UTC--2018-07-11T13-56-44.639284480Z--d11acfdd6acd4eb67f63206126405ccae02b922e",
	"./keys/UTC--2018-07-11T13-56-56.095205206Z--2eb657dc98ad6957dddd1c90d35f2160ec265053",
	"./keys/UTC--2018-07-11T13-56-57.574414965Z--6ae0845898a2f6bfd5dbd2f1bfd8761ad7079269",
	"./keys/UTC--2018-07-11T13-56-59.014254718Z--904c978c73ccded6b1ae72e168c6771b48679187",
	"./keys/UTC--2018-07-11T13-57-02.558271931Z--a26e9c30fa84e7cb8a4c376a5c7c5a262d2e3d1c",
	"./keys/UTC--2018-07-11T13-57-04.062422840Z--42a012c7b19cf82eb91da0f3821df66b6bb3b5eb",
	"./keys/UTC--2018-07-11T13-57-05.526312874Z--fa4b6e66b6de8a16f91340bb3f46bb264ca9ce56",
	"./keys/UTC--2018-07-11T13-57-06.981311435Z--eb0766de01282407a4cf182a33dbb8d2747dc553"
]
var password = '1234'
ConvertKeyFile(keys, password)

