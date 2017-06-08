echo "Nom info : "$1
echo "Element : "$2;
echo "Base : "$3;

#req="db.$3.insert({$1:\"$2\"})";
#req="db.$3.insert({'$1':},{$set:{'$1':'$2'}})";
#req="db.$3.insert({"

req="db.$3.update({\"_id\": ObjectId(\"591187d2edd1c297d6557de4\")}, { \"$1\" : \"$2\" })";
echo "requete :"$req;
echo $req | mongo $3
