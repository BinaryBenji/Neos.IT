#!/bin/sh

user=$(snmpget -v1 -c public 127.0.0.1 1.3.6.1.4.1.2021.11.9.0 | cut -d " " -f4) 
system=$(snmpwalk -v1 -c public 127.0.0.1 1.3.6.1.4.1.2021.11.10.0| cut -d " " -f4)
no_use=$(snmpwalk -v1 -c public 127.0.0.1 1.3.6.1.4.1.2021.11.11.0| cut -d " " -f4)

echo "Utilisateur cpu : "$user%;
echo "System cpu : "$system%;
echo "CPU : "$no_use%;

#rep="db.super_infos.insert({System_cpu:\"$system\"})";
#echo $req | mongo super_infos

#rep="db.super_infos.insert({non_use_cpu:\"$no_use\"})";
#echo $req | mongo super_infos

#rep="db.super_infos_insert({utilisateur_cpu:\"$user\"})";
#echo $req | mongo super_infos
