var https = require('https'),
    http  = require('http'),
    util  = require('util'),
    path  = require('path'),
    fs    = require('fs'),
    colors = require('colors'),
    httpProxy = require('http-proxy');

var targetLink = 'https://gorest.co.in/public-api/',
	targetHost = 'gorest.co.in';

var port = 8011;

//
// Create a HTTP Proxy server with a HTTPS target
//
httpProxy.createProxyServer({
  target: targetLink,
  agent  : https.globalAgent,
  headers: {
    host: targetHost
  }
}).listen(port);

util.log('http proxy server'.blue + ' started '.green.bold + 'on port '.blue + port.toString().yellow);