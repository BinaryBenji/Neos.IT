#!/bin/bash
for arg in $@
do
    grep "$1" /etc/asterisk/userlist &>/dev/null
    if [ "$?" = "0" ]
    then
	sed -ie "/\b$1\b/d" /etc/asterisk/userlist &>/dev/null
    else
	echo "Utilisateur non existant"
	exit
    fi
    if (test -e /etc/asterisk/include/sip/$1.conf)
    then
	rm /etc/asterisk/include/sip/$1.conf
    fi
    grep "/sip/$1.conf" /etc/asterisk/sip.conf &>/dev/null
    if [ "$?" = "0" ]
    then
	sed -ie "/$1.conf/d" /etc/asterisk/sip.conf &>/dev/null
    fi
    number=$(grep "$1" /etc/asterisk/include/extensions/users.conf |  cut -d',' -f1 | cut -d" " -f3)
    if [ "$?" = "0" ]
    then
	sed -ie "/\b$number\b/d" /etc/asterisk/include/extensions/users.conf &>/dev/null
    fi
    grep "$number" /etc/asterisk/include/extensions/voicemail.conf &>/dev/null
    if [ "$?" = "0" ]
    then
	sed -ie "/\b$number\b/{N;d}" /etc/asterisk/include/extensions/voicemail.conf &>/dev/null
    fi
    grep "$1" /etc/asterisk/voicemail.conf &>/dev/null
    if [ "$?" = "0" ]
    then
	sed -ie "/\b$1\b/d" /etc/asterisk/voicemail.conf &>/dev/null
    fi
    asterisk -rx reload
done
   
