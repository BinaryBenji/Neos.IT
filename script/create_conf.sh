#!/bin/bash

if (test -e /etc/asterisk/include/extensions/conferences.conf)
then
    number=$(cat /etc/asterisk/include/extensions/conferences.conf | tail -n 1 | cut -d',' -f1 | cut -d" " -f3)
    let number=number+10
    echo "exten => $number,1,Answer()
exten => $number,n,ConfBridge(4444,testbridge,testuser,testmenu)" >> /etc/asterisk/include/extensions/conferences.conf
    echo "Conférence [$number]"
    echo "db.conferences.insert({Number : \"$number\"})" | mongo conferences
    asterisk -rx reload
fi
