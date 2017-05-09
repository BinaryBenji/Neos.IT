#!/bin/bash

nb_carte=$(snmpget -v1 -c public 127.0.0.1 ifNumber.0 | cut -d " " -f4)

echo -e "Nombre de carte reseau : "$nb_carte"\n";

for ((i=2;i<=2;i++)) #de 1 a nb carte max
do

#ping maybe
name=$(snmpget -v1 -c public 127.0.0.1 ifName.$i | cut -d " " -f4)
#octen=$(snmpget -v1 -c public 127.0.0.1 ifInOctets.$i | cut -d " " -f4)
#octso=$(snmpget -v1 -c public 127.0.0.1 ifOutOctets.$i | cut -d " " -f4)
statu=$(snmpget -v1 -c public 127.0.0.1 ifOperStatus.$i | cut -d " " -f4)
#info=$(snmpget -v1 -c public 127.0.0.1 ifDescr.$i | cut -d " " -f4)
#typ=$(snmpget -v1 -c public 127.0.0.1 ifType.$i | cut -d " " -f4)
ad_p=$(snmpget -v1 -c public 127.0.0.1 ifPhysAddress.$i | cut -d " " -f4)
mtu=$(snmpget -v1 -c public 127.0.0.1 ifMtu.$i | cut -d " " -f4)
#b_p=$(snmpget -v1 -c public 127.0.0.1 ifSpeed.$i | cut -d " " -f4)
#error=$(snmpget -v1 -c public 127.0.0.1 ifInErrors.$i | cut -d " " -f4)

echo "Nom de la carte reseau : "$name;
#echo "Octect entrant :"$octen;
#echo "Octect sortant :"$octso;

#let "bit_e=($octen*8)"
#let "bit_s=($octso*8)"
#e=`echo $bit_e | cut -c\1\-\3`
#s=`echo $bit_s | cut -c\1\-\3`
echo "Status : "$statu;
#echo "information : "$info";" $typ;
echo "Addresse Physique : "$ad_p;
echo "MTU : "$mtu;
echo IP : `hostname -i`
#echo "Error : "$error;
#echo "Bande Passante : "$b_p;
#echo "Bit entrant : "$e"Mbit ";
#echo -e "Bit sortant :"$s"Mbit \n";
done
echo IP : `hostname -i`
#sh addbase.sh $super_ip

