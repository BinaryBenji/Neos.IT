#!/bin/bash

if [ $# -lt 3 ]; then
    echo "Usage : ./script Username Password VoiceMail[0:1] VoiceMailPassword"
    echo "-1" > /etc/asterisk/returnvalue
    exit
else
    if !(test -e /etc/asterisk/include/sip/$1.conf)
    then
	echo "[$1]
        username = $1
        secret=$2
        type=friend
        host=dynamic
        dtmfmode=rfc2833
        disallow=all
	videosupport=yes
        allow=ulaw,h263
        context=phones" > /etc/asterisk/include/sip/$1.conf
	grep "/sip/$1.conf" /etc/asterisk/sip.conf
	if [ "$?" != "0" ]
	then
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
		if [ $4 ]
		   then
		       echo "exten => $number,n,VoiceMail($number)" >> /etc/asterisk/include/extensions/users.conf
		       echo "$number => $4,$1,$1@neos.com" >> /etc/asterisk/voicemail.conf
		       voicemailnumber=$(cat /etc/asterisk/include/extensions/voicemail.conf | tail -n 2 | head -n 1 | cut -d',' -f1 | cut -d" " -f3)
		       let voicemailnumber=voicemailnumber+10
		       echo "exten => $voicemailnumber,1,VoiceMailMain($number)
same => n,Hangup()" >> /etc/asterisk/include/extensions/voicemail.conf
		fi
	    fi
	    echo "exten => $number,n,Hangup()" >> /etc/asterisk/include/extensions/users.conf
	fi
	echo "Compte [$1] - Numéro téléphone : [$number] - Boite vocale [$voicemailnumber]"
	asterisk -rx reload
	mongo --eval "db.users.find({username : \"$1\"}).limit(1).count()" users > /etc/asterisk/result
	return=$(tail -n 1 /etc/asterisk/result)
	if [ $return = 0 ]
	then
	    echo "db.users.insert({username : \"$1\", password : \"$2\", number : \"$number\", voicemailok : \"$3\", voicenumber: \"$voicemailnumber\", voicepass: \"$4\"})" | mongo users
	fi
        echo "0" > /etc/asterisk/returnvalue
    else
        echo "-1" > /etc/asterisk/returnvalue
    fi
fi
