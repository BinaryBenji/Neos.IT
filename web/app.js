var express = require('express');
var app = express();
var path = require("path");

app.set('views', __dirname + '/views');
app.set('public', __dirname + '/public');
app.engine('html', require('ejs').renderFile);
app.use(express.static(__dirname + '/public'));
app.use('/public', express.static(path.join(__dirname, 'public')));

app.get('/', function (req, res) {
    res.render('vitrine.html');
});

app.get('/download', function (req, res) {
    res.render('download.html');
});

app.get('/talk', function (req, res) {
    res.render('talk.html');
});

app.listen(3000, function () {
    console.log('En ecoute sur le port : 3000!');
});
