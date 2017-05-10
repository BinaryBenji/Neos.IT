#!/bin/bash

d=$(date);

echo "date :"$d;
#rsync -e ssh / 

git add *
git commit -m "$d"
git push origin master<<EOF
lLalLu93
azerty972
EOF

