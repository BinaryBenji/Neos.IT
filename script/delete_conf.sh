#!/bin/bash

for arg in $@
do
    grep "$1" /etc/asterisk/include/extensions/conferences.conf &>/dev/null
    if [ "$!" != "0" ]
    then
	sed -ie "/\b$1\b/d" /etc/asterisk/include/extensions/conferences.conf &>/dev/null
	mongo --eval "db.conferences.find({Number : \"$1\"}).limit(1).count()" conferences > /etc/asterisk/resultconf
	return=$(tail -n 1 /etc/asterisk/resultconf)
	if [ $return = 1 ]
	then
	    echo "db.conferences.remove({Number : \"$1\"})" | mongo conferences
	fi
	asterisk -rx reload
		    
    fi
done
