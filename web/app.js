var express = require('express');
var app = express();
var path = require("path");
//var favicon = require('express-favicon');

//app.use(favicon(__dirname + '/public/img/favicon.ico'));
//app.use(express.static('public'))
app.set('views', __dirname + '/views');
app.set('public', __dirname + '/public');
//app.set('public', __dirname + '/public');
app.engine('html', require('ejs').renderFile);
app.use(express.static(__dirname + '/public'));
app.use('/public', express.static(path.join(__dirname, 'public')));
//app.use(favicon(__dirname + '/public/img/favicon'));

app.get('/', function (req, res) {
    res.render('vitrine.html');
});

app.get('/download', function (req, res) {
    res.render('download.html');
});

app.get('/talktoneos', function (req, res) {
    res.render('talktoneos.html');
});

app.listen(3000, function () {
    console.log('En ecoute sur le port : 3000!');
});
