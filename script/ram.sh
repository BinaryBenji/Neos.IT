a=$(snmpget -v 1 -Ovq -c public 127.0.0.1 hrStorageSize.1)
b=$(snmpget -v 1 -Ovq -c public 127.0.0.1 hrStorageUsed.1)

new=$(echo "scale=1; $b/$a*100" | bc -l)

#find

ram4="db.super_infos.find({\"_id\": ObjectId(\"591957d5b0d58eabc9dfda07\")})"
ram3="db.super_infos.find({\"_id\": ObjectId(\"591957cbb0d58eabc9dfda06\")})"
ram2="db.super_infos.find({\"_id\": ObjectId(\"591957c5b0d58eabc9dfda05\")})"
ram1="db.super_infos.find({\"_id\": ObjectId(\"591957c1b0d58eabc9dfda04\")})"
ram0="db.super_infos.find({\"_id\": ObjectId(\"591957b8b0d58eabc9dfda03\")})"
newram=$new

eram4=$(echo $ram4 | mongo super_infos)
eram3=$(echo $ram3 | mongo super_infos)
eram2=$(echo $ram2 | mongo super_infos)
eram1=$(echo $ram1 | mongo super_infos)
eram0=$(echo $ram0 | mongo super_infos)


nram4=$(echo $eram4 | cut -c116-117)
nram3=$(echo $eram3 | cut -c116-117)
nram2=$(echo $eram2 | cut -c116-117)
nram1=$(echo $eram1 | cut -c116-117)
nram0=$(echo $eram0 | cut -c116-117)

echo "future ram0 : "$newram
echo "future ram1 : "$nram0
echo "future ram2 : "$nram1
echo "future ram3 : "$nram2
echo "future ram4 : "$nram3
echo "future ram5 : "$nram4

# update

rram5="db.super_infos.update({\"_id\": ObjectId(\"591957dcb0d58eabc9dfda08\")}, { \"ram5\" : \"$nram4\" })";
rram4="db.super_infos.update({\"_id\": ObjectId(\"591957d5b0d58eabc9dfda07\")}, { \"ram4\" : \"$nram3\" })";
rram3="db.super_infos.update({\"_id\": ObjectId(\"591957cbb0d58eabc9dfda06\")}, { \"ram3\" : \"$nram2\" })";
rram2="db.super_infos.update({\"_id\": ObjectId(\"591957c5b0d58eabc9dfda05\")}, { \"ram2\" : \"$nram1\" })";
rram1="db.super_infos.update({\"_id\": ObjectId(\"591957c1b0d58eabc9dfda04\")}, { \"ram1\" : \"$nram0\" })";
rram0="db.super_infos.update({\"_id\": ObjectId(\"591957b8b0d58eabc9dfda03\")}, { \"ram0\" : \"$newram\" })";


echo $rram5 | mongo super_infos
echo $rram4 | mongo super_infos
echo $rram3 | mongo super_infos
echo $rram2 | mongo super_infos
echo $rram1 | mongo super_infos
echo $rram0 | mongo super_infos
