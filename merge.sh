#!/bin/sh

if [ $# -ne 1 ]; then
	echo argc error
	exit
fi
if [ ! -d data/$1 ]; then
	echo $1 is not dir
	exit
fi
touch total_data_$1
for file in `ls data/$1`
do
	cat data/$1/$file >> total_data_$1
done
