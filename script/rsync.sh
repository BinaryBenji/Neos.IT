#!/bin/bash

d=$(echo`date`);
echo "d :"$d;

rsync -e ssh / 
