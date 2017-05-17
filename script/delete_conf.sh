#!/bin/bash

for arg in $@
do
    grep "$1" /etc/asterisk/include/extensions/conferences.conf &>/dev/null
    if [ "$!" != "0" ]
    then
	sed -ie "/$1/d" /etc/asterisk/include/extensions/conferences.conf &>/dev/null
	asterisk -rx reload
    fi
done
