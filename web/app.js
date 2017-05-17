var express = require('express');
var app = express();

app.get('/', function (req, res) {
    res.send('Bienvenue sur Neos LOLMESDR);
});

app.listen(3000, function () {
    console.log('En ecoute sur le port : 3000!');
});
