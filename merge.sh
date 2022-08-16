#!/bin/sh

if [ $# -eq 1 ]; then
	if [ ! -d data/$1 ]; then
		echo data/$1 is not dir
		exit
	fi
	if [ -f total_data_$1_0 ]; then
		rm -f total_data_$1_0
	fi
	for file in `ls data/$1`
	do
		cat data/$1/$file >> temp_$1_$file
		sed -i 's/^date/month\t&/' temp_$1_$file
		sed -i 's/^[0-9]/'"$file"'\t&/' temp_$1_$file
		cat temp_$1_$file >> total_data_$1_0
		rm -f temp_$1_$file
	done
elif [ $# -eq 2 ]; then
	if [ ! -f data/$1/$2 ]; then
		echo data/$1/$2 is not file
		exit
	fi
	if [ -f total_data_$1_$2 ]; then
		rm -f total_data_$1_$2
	fi
	cat data/$1/$2 >> total_data_$1_$2
fi
