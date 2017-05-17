#!/bin/bash

if [ $# -lt 3 ]; then
    echo "Usage : ./script Username Password VoiceMail[0:1] VoiceMailPassword"
    exit
else
    if !(test -e /etc/asterisk/include/sip/$1.conf)
    then
	echo "l'utilisateur n'existe pas, creation en cours"
	echo "[$1]
        username = $1
        secret=$2
        type=friend
        host=dynamic
        dtmfmode=rfc2833
        disallow=all
        allow=ulaw
        context=phones" > /etc/asterisk/include/sip/$1.conf
	echo "creation OK"
	grep "/sip/$1.conf" /etc/asterisk/sip.conf
	if [ "$?" != "0" ]
	then
	    echo "il y est pas, on ajoute"
	    echo "on ajoute le include dans sip.conf"
	    echo "#include \"/etc/asterisk/include/sip/$1.conf\"" >> /etc/asterisk/sip.conf
	fi
	number=$(cat /etc/asterisk/include/extensions/users.conf | tail -n 1 | cut -d',' -f1 | cut -d" " -f3)
	let number=number+10
	grep "SIP/$1" /etc/asterisk/include/extensions/users.conf
	if [ "$?" != "0" ]
	then
	    echo "exten => $number,1,NoOp(Communication en cours)
exten => $number,n,Dial(SIP/$1,10)" >> /etc/asterisk/include/extensions/users.conf
	    if [ "$3" = 1 ]
	    then
		echo "vous voulez une boite vocale"
		if [ $4 ]
		   then
		       echo "exten => $number,n,VoiceMail($number)" >> /etc/asterisk/include/extensions/users.conf
		       echo "$number => $4,$1,$1@neos.com" >> /etc/asterisk/voicemail.conf
		       voicemailnumber=$(cat /etc/asterisk/include/extensions/voicemail.conf | tail -n 2 | head -n 1 | cut -d',' -f1 | cut -d" " -f3)
		       let voicemailnumber=voicemailnumber+10
		       echo "exten => $voicemailnumber,1,VoiceMailMain($number)
same => n,Hangup()" >> /etc/asterisk/include/extensions/voicemail.conf
		else
		    echo "mais vous avez oublié le mdp"
		fi
	    fi
	    echo "exten => $number,n,Hangup()" >> /etc/asterisk/include/extensions/users.conf
	fi
	echo "Compte [$1] - Numéro téléphone : [$number] - Boite vocale [$voicemailnumber]"
	echo "$1" >> /etc/asterisk/userlist
	asterisk -rx reload
    fi
fi
