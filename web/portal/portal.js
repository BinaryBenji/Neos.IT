// VARIABLES

var express = require('express');
var app = express();
var path = require("path");
var bodyParser = require('body-parser');
var sessions = require('express-session');
var session;

var db = require('mongodb'),
    Server = require('mongodb').Server,
    ObjectID = require('mongodb').ObjectID;
var MongoClient = require('mongodb').MongoClient;
var database_superinfos = 'mongodb://127.0.0.1:27017/super_infos';

// Errors
var falseauth = 0;
var false_crea_user = 0;
var false_crea_conf = 0;

var txt_false_crea_user = "";
var txt_false_crea_conf = "";
var errco = "";
var fs = require('fs'),
    https = require('https');

/*var options = {
    key: fs.readFileSync('/etc/certs/key.pem'),
    cert: fs.readFileSync('/etc/certs/cert.pem')
};*/


// PARAMETRES

app.set('views', __dirname + '/views');
app.engine('html', require('ejs').renderFile);
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({extended:true}));
app.use(sessions({
    secret: '&é"(-è_çà)=$ù!:;,?./§µ%£°',
    resave: false,
    saveUnitialized: true
}));


// IDENTIFIANTS POUR MONGODB

// Hardware
var id_ip = new ObjectID('591187d2cd10ca7bb3e2147d');
var id_statut = new ObjectID('591187d20c29ce1305773583');
var id_name = new ObjectID('591187d24cb031aedf78b9ae');
var id_phys_addr = new ObjectID('591187d22727f3c8646130ac');

var id_ram0 = new ObjectID('591957b8b0d58eabc9dfda03');
var id_ram1 = new ObjectID('591957c1b0d58eabc9dfda04');
var id_ram2 = new ObjectID('591957c5b0d58eabc9dfda05');
var id_ram3 = new ObjectID('591957cbb0d58eabc9dfda06');
var id_ram4 = new ObjectID('591957d5b0d58eabc9dfda07');
var id_ram5 = new ObjectID('591957dcb0d58eabc9dfda08');

// Network
var id_ping = new ObjectID('591187d2edd1c297d6557de4');
var id_mtu = new ObjectID('591187d212b978a5a5ab580b');
var id_cpu = new ObjectID('5913038064e77620aab4eabb');

// Asterisk
var id_active_channels = new ObjectID('591c25fa418239770510b57a');
var id_active_calls = new ObjectID('591c2601418239770510b57b');
var id_calls_processed = new ObjectID('591c2617418239770510b57c');


// ROUTES & MIDDLEWARES

MongoClient.connect(database_superinfos, function(err, db) {
   if (err){
       console.log("Erreur dans la connexion ");
   }
    else{
	console.log("Connecté a Mongodb.");
	collection = db.collection('super_infos');
	// Toutes les recherches dans la base super_infos
	db.collection('super_infos', function(error, collection) {
	    // Requete IP
	    collection.findOne({_id:id_ip},function(err, docs) {
		ip = JSON.stringify(docs);
	    });
	    // Requete Status
	    collection.findOne({_id:id_statut},function(err, docs) {
		statut = JSON.stringify(docs);
	    });
	    // Requete Name
	    collection.findOne({_id:id_name},function(err, docs) {
		name = JSON.stringify(docs);
	    });
	    // Requete Adresse Physique
	    collection.findOne({_id:id_phys_addr},function(err, docs) {
		phys_addr = JSON.stringify(docs);
	    });
	    // Requete Ram0
	    collection.findOne({_id:id_ram0},function(err, docs) {
		ram0 = JSON.stringify(docs);
	    });
	    // Requete Ram1
	    collection.findOne({_id:id_ram1},function(err, docs) {
		ram1 = JSON.stringify(docs);
	    });
	    // Requete Ram2
	    collection.findOne({_id:id_ram2},function(err, docs) {
		ram2 = JSON.stringify(docs);
	    });
	    // Requete Ram3
	    collection.findOne({_id:id_ram3},function(err, docs) {
		ram3 = JSON.stringify(docs);
	    });
	    // Requete Ram4
	    collection.findOne({_id:id_ram4},function(err, docs) {
		ram4 = JSON.stringify(docs);
	    });
	    // Requete Ram5
	    collection.findOne({_id:id_ram5},function(err, docs) {
		ram5 = JSON.stringify(docs);
	    });
	    // Requete Ping
	    collection.findOne({_id:id_ping},function(err, docs) {
		ping = JSON.stringify(docs);
	    });
	    // Requete MTU
	    collection.findOne({_id:id_mtu},function(err, docs) {
		mtu = JSON.stringify(docs);
	    });
	    // Requete CPU
	    collection.findOne({_id:id_cpu},function(err, docs) {
		cpu = JSON.stringify(docs);
	    });
	    // Requete Active Channels
	    collection.findOne({_id:id_active_channels},function(err, docs) {
		active_channels = JSON.stringify(docs);
	    });
	    // Requete Active Calls
	    collection.findOne({_id:id_active_calls},function(err, docs) {
		active_calls = JSON.stringify(docs);
	    });
	    // Requete Calls Processed
	    collection.findOne({_id:id_calls_processed},function(err, docs) {
		calls_processed = JSON.stringify(docs);
	    });
	});
	console.log("OK MONGO");
    }
});

app.get('/', function (req, res){
    if (falseauth == 1)
    {
	errco = "Mot de passe incorect";
	console.log("Mot de pass entre incorect");
    }
    else
    {
	errco = "Connectez vous";
    }
    res.render('login.ejs',{errco: errco});
});


	
// Creation de la session apres soumission des donnees dans le formulaire
app.post('/',function(req, res){
    session = req.session;
    session.uniqueID = req.body.username;
    pass = req.body.password;
    console.log("Traitement de l'auth");
    if(session.uniqueID && req.body.password){
	res.redirect('/redirect');
    }
    else{
	console.log('Bad input');
	res.redirect('/');
    }
});

// Verif auth() + connexion
app.get('/redirect', function(req, res) {
    session = req.session;
    if(session.uniqueID == "admin"){
	console.log(session);
	falseauth = 0;
	res.redirect('/admin');
    }
    else{
	falseauth = 1;
	console.log("Auth ratee");
	res.redirect('/logout');
    }
});

// Deconnexion (Destruction session)
app.get('/logout', function (req,res){
    req.session.destroy(function(error){
	console.log('erreur : ' + error + '(il peut ne pas y avoir d\'erreur)');
	console.log('destruction de la session');
	res.redirect('/');
    });
});

// Panel admininstration
app.get('/admin', function(req, res){
    if(session.uniqueID){
	res.render('admin.ejs');
    }
    else{
	req.session.destroy(function(error){
	    console.log('erreur : ' + error);
	    res.redirect('/');
	});
	res.render('login.ejs');
    }
});

// Panel supervision
app.get('/sup', function(req, res){
    if(session.uniqueID){
	console.log('Connecté panel supervision');
	res.render('sup.ejs', {ip:ip, statut:statut, name:name, phys_addr:phys_addr, ram0:ram0, ram1:ram1, ram2:ram2, ram3:ram3,
			       ram4:ram4, ram5:ram5, ping:ping, mtu:mtu, cpu:cpu
			      });
    }
    else{
	req.session.destroy(function(error){
	    console.log('erreur : ' + error);
	    res.redirect('/');
	});
	res.render('login.ejs');
    }
});


// Panel asterisk
app.get('/ast', function(req, res){
    if(session.uniqueID){
	
	if (false_crea_conf == 0)
	    txt_false_crea_conf = "";
	else if (false_crea_conf == 1)
	    txt_false_crea_conf = "Veuillez entrer un numéro valide";
	else if (false_crea_conf == 2)
	    txt_false_crea_conf = "Conférence crée";
	console.log('False conf : ' + false_crea_conf);

	if (false_crea_user == 0)
	    txt_false_crea_user = "";
	else if (false_crea_user == 1)
	    txt_false_crea_user = "Veuillez entrer un nom d\'utilisateur valide";
	else if (false_crea_user == 2)
	    txt_false_crea_user = "Utilisateur crée";
	console.log('False user : ' + false_crea_user);
	
	
	res.render('ast.ejs', {active_channels:active_channels, active_calls:active_calls, calls_processed:calls_processed, txt_false_crea_conf:txt_false_crea_conf, txt_false_crea_user:txt_false_crea_user});
    }
    else{
	req.session.destroy(function(error){
	    console.log('erreur : ' + error);
	    res.redirect('/');
	});
	res.render('login.ejs');
    }
    false_crea_conf = 0;
    false_crea_user = 0;
});


// Creation de conférence
app.post('/crea_conf', function(req, res){
    // Renvoie false si l'entree n'est pas un int
    function is_int(value){
	if((parseFloat(value) == parseInt(value)) && !isNaN(value)){
	    return true;
	} else {
	    return false;
	}
    }
    false_crea_conf = 0;    
    if(session.uniqueID){
	name_conf = req.body.name_conf;
	if (is_int(name_conf) == false){
	    false_crea_conf = 1;
	    console.log('Bad input');
	    res.redirect('/ast');
	}
	else{
	    false_crea_conf = 2;
	    console.log("Creation de l\'audioconférence : " + name_conf);
	    res.redirect('/ast');
	}
    }
    else{
    req.session.destroy(function(error){
	console.log('erreur : ' + error);
	res.redirect('/');
    });
	res.render('login.ejs');
    }
});

// Creation utilisateur
app.post('/crea_user', function(req, res){
    // Renvoie false si l'entree n'est pas un string
    function is_str(str) {
	return /^[a-zA-Z]+$/.test(str);
    }
    false_crea_user = 0;
    if(session.uniqueID){
	name_user = req.body.name_user;
	if (is_str(name_user) == false){
	    false_crea_user = 1;
	    console.log('Bad input');
	    res.redirect('/ast');
	}
	else{
	    false_crea_user = 2;
	    console.log("Creation de l\'audioconférence : " + name_user);
	    res.redirect('/ast');
	}
    }
    else{
	req.session.destroy(function(error){
	    console.log('erreur : ' + error);
	    res.redirect('/');
	});
	res.render('login.ejs');
    }
});


// Ecoute port 4000
app.listen(4000, function () {
    console.log('En ecoute sur le port : 4000!');
});

