echo "Element : "$1;
echo "Base : "$2;

req="db.$2.insert({$2:\"$1\"})";
echo $req | mongo $2
