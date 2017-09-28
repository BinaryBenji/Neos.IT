sudo apt-get --assume-yes install asterisk
echo "Paquet asterisk téléchargé"
echo "Vérification d'existence du dossier /Neos.IT/ ..."
if !(test -d /Neos.IT/)
then
    echo "KO"
    echo "Création ..."
    sudo mkdir /Neos.IT/
    if [ $? = "0" ]
    then
	echo "OK"
    else
	echo "KO"
    fi
else
    echo "KO"
fi
i=0
echo "Copie des scripts ..."
sudo cp -rf script /Neos.IT/
if [ $? = "0" ]
then
    echo "OK"
    let i=i+1
else
    echo "KO"
fi
echo "Copie des ressources d'asterisk ..."
sudo cp -rf asterisk_ressources/include /etc/asterisk/
if [ $? = "0" ]
then
    echo "OK"
    let i=i+1
else
    echo "KO"
fi
echo "Copie des ressources additionnelles d'asterisk ..."
sudo cp asterisk_ressources/conf/* /etc/asterisk/
if [ $? = "0" ]
then
    echo "OK"
    let i=i+1
else
    echo "KO"
fi
echo "Vérification de l'intégrité des fichiers asterisk ..."
if [ $i -eq "3" ]
then
    echo "OK"
else
    echo "KO"
fi
hostname=`hostname -i`
echo "Vérification existence fichier /etc/asterisk/include/sip/general.conf ..."
if (test -e /etc/asterisk/include/sip/general.conf)
then
    echo "OK"
    echo "Copie adresse IP ..."
    sudo sed -i.bak -E 's/^([ \t]*localnet[ \t]*=[ \t]*).*/\1'"$hostname"'/' /etc/asterisk/include/sip/general.conf
    if [ $? = "0" ]
    then
	echo "OK"
    else
	echo "KO"
    fi
fi
sudo apt-get --assume-yes install mongodb
echo "Paquet asterisk téléchargé"
echo "Ajout sur la base de donnée des utilisateurs asterisk ..."
echo "db.users.insert({username : \"X\", password : \"X\", number : \"$X\", voicemailok : \"X\", voicenumber: \"X\", voicepass: \"X\"})" | mongo users
echo "db.users.insert({username : \"test\", password : \"test\", number : \"100\", voicemailok : \"1\", voicenumber: \"111\", voicepass: \"1234\"})" | mongo users
echo "Ajout sur la base de donnée des conférences asterisk ..."
echo "db.conferences.insert({Number : \"$number\"})" | mongo conferences
echo "db.conferences.insert({Number : \"1010\"})" | mongo conferences
echo "Installation d'asterisk terminée"
sudo apt-get --assume-yes install snmp
sudo apt-get --assume-yes install snmpd
sudo apt-get --assume-yes install snmp-mibs-downloader
echo "Vérification d'existence de /etc/snmp/snmp.conf ..."
if (test -e /etc/snmp/snmp.conf)
then
    echo "OK"
    echo "Suppression ligne /etc/snmp/snmp.conf ..."
    sudo sed -ie "/:/d" /etc/snmp/snmp.conf
    if [ $? = "0" ]
    then
	echo "OK"
	echo "Ajout ligne ..."
	sudo sh -c "echo '' >> /etc/snmp/snmp.conf"
	if [ $? != "0" ]
	then
	    echo "KO"
	else
	    echo "OK"
	fi
    else
	echo "KO"
    fi
else
    echo "KO"
fi
echo "Vérification existence snmpd.conf ..."
if (test -e /etc/snmp/snmpd.conf)
then
    echo "OK"
    echo "Copie snmpd.conf"
    sudo cp snmp/snmpd.conf /etc/snmp/
    if [ $? = "0" ]
    then
	echo "OK"
    else
	echo "KO"
    fi
    sudo /etc/init.d/snmpd restart
else
    echo "KO"
fi
echo "Installation packet nodejs"
sudo apt-get --assume-yes install nodejs
sudo apt-get --assume-yes install nodejs-legacy
echo "Installation packet git"
sudo apt-get --assume-yes install git
git clone https://github.com/BinaryBenji/Neos.IT.git
echo "Copie des fichiers web ..."
mkdir -p /var/www
sudo cp -rf Neos.IT/web/* /var/www/
if [ $? = "0" ]
then
    echo "OK"
else
    echo "KO"
fi
mongorestore --db super_infos /super_infos/super_infos.bson
mongorestore --db authentication /authentication/authentication.bson
sudo nohup node /var/www/app.js > /dev/null 2>&1 &
sudo nohup node /var/www/portal/portal.js > /dev/null 2>&1 &
