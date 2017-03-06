

var KeyEncoder = require('key-encoder'),
    keyEncoder = new KeyEncoder('secp256k1')

var rawPrivateKey = process.argv[2];

var pemPrivateKey = keyEncoder.encodePrivate(rawPrivateKey, 'raw', 'pem')

console.log(pemPrivateKey);
