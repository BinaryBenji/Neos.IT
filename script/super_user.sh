while true ; do

    data=$(asterisk -rx "core show channels" |tail -3)
    #echo $active_calls
    active_channels=$(echo $data | awk '{ print $5}')
    active_calls=$(echo $data | awk '{ print $8}')
    calls_processed=$(echo $data | awk '{ print $11}')

    echo "active channels : "$active_channels
    echo "active calls : "$active_calls
    echo "calls processed : "$calls_processed

    req1="db.super_infos.update({\"_id\": ObjectId(\"591c25fa418239770510b57a\")}, { \"active_channels\" : \"$active_channels\" })";
    req2="db.super_infos.update({\"_id\": ObjectId(\"591c2601418239770510b57b\")}, { \"active_calls\" : \"$active_calls\" })";
    req3="db.super_infos.update({\"_id\": ObjectId(\"591c2617418239770510b57c\")}, { \"calls_processed\" : \"$calls_processed\" })";
    
    
    echo $req1 |mongo super_infos
    echo $req2 |mongo super_infos
    echo $req3 |mongo super_infos
    
    sleep 5;
done
