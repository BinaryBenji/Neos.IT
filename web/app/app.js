//var MongoClient = require('mongodb').MongoClient;
//var db;
var express = require('express');
var app = express();

/*MongoClient.connect("mongodb://localhost:27017/super_infos", function(err, database) {
    if(err) return console.error(err);
    console.log('Connected to mongo');
    db = database;
    db.collection('')
});*/

var MongoClient = require('mongodb').MongoClient;

app.get('/', function (req, res) {
    res.send('Bienvenue sur Neos !');
});

app.listen(3000, function () {
    console.log('En ecoute sur le port : 3000!');
});
