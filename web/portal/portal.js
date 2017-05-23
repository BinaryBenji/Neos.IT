var express = require('express');
var app = express();
var path = require("path");

app.set('views', __dirname + '/views');
app.engine('html', require('ejs').renderFile);

app.get('/', function (req, res) {
    res.render('portal.html');
});

/*app.get('/download', function (req, res) {
    res.render('download.html');
});

app.get('/talktoneos', function (req, res) {
    res.render('talktoneos.html');
});*/

app.listen(4000, function () {
    console.log('En ecoute sur le port : 4000!');
});
