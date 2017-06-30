sudo apt --assume-yes remove asterisk
mongo users --eval "db.dropDatabase()"
mongo conferences --eval "db.dropDatabase()"
sudo apt --assume-yes remove mongodb* --purge
sudo apt --assume-yes remove snmp* --purge
sudo rm -rf /etc/asterisk/
sudo rm -rf /Neos.IT/
sudo apt --assume-yes remove nodejs --purge
sudo apt --assume-yes remove nodejs-legacy --purge
sudo apt --assume-yes remove git --purge
sudo rm -rf Neos.IT
sudo rm nohup.out
