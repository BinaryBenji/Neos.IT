[phones]

exten => 100,1,NoOp(Communication en cours); Pas d'opération
exten => 100,n,Playback(goodbye);Musique
exten => 100,n,Dial(SIP/lael);Dialoque avec le destinataire 
exten => 100,n,Playback(tt-allbusy);Musique 
exten => 100,n,Hangup();raccroche

exten => 200,1,NoOp(Communication en cours)
exten => 200,n,Playback(samagadiola)
exten => 200,n,Dial(SIP/benji)
exten => 200,n,Playback(samagadiola)
exten => 200,n,Hangup()

exten => 300,1,NoOp(Communication en cours)
exten => 300,n,Playback(sorry)
exten => 300,n,Dial(SIP/micka)
exten => 300,n,Playback(hours)
exten => 300,n,Hangup()


exten => 301,1,NoOp(Communication en cours)
exten => 301,n,Playback(sorry)
exten => 301,n,Dial(SIP/michael)
exten => 301,n,Playback(hours)
exten => 301,n,Hangup()


 ;Expression regular 
exten => _1.,1,Goto(outgoing,1111,1);outside 
exten => _2.,1,Goto(outgoing,2222,1);lael
exten => _3X.,1,Goto(outgoing,3333,1); _0X. n'importe quel numéro qui commence par 3
exten => _4X.,1,Goto(outgoing,4444,1); _0X. n'importe quel numéro qui commence par 3
;exten => _XXXX,1,Goto(outgoing,1111,4); _XXXX n'importe quel numéro sur micka 

exten => 8888,n,Goto(outgoing,8888,2)

[outgoing] ;	Redirection vers l'extérieur

exten => 1111,1,NoOp(n° ${EXTEN:1:4}); Voir le numéro composé à partir du 2eme nombre au 4e
exten => 1111,n,Dial(SIP/outside)
exten => 1111,n,Hangup()

exten => 2222,1,NoOp(numéro composé:${EXTEN:-3});même chose en partant vers le bas
exten => 2222,n,Dial(SIP/lael)
exten => 2222,n,Hangup()

exten => 3333,1,NoOp(numéro composé:${EXTEN})
exten => 3333,n,Dial(SIP/benji)
exten => 3333,n,Hangup()

exten => 4444,1,NoOp(numéro composé:${EXTEN})
exten => 4444,n,Dial(SIP/micka)
exten => 4444,n,Hangup()

[incoming] ; Systeme de messagerie

exten => 0614466935,1,GotoIfTime(18:30-19:30,mon-fri,*,*?phones,100,1)
exten => 0614466935,n,Playback(tt-monkeys)
exten => 0614466935,n,Playback(sorry)
exten => 0614466935,n,Hangup()

 ;	Redirection vers l'intérieur
exten => 0673420180,1,Goto(phones,300,1)
exten => 0652236767,1,Goto(phones,200,1)
