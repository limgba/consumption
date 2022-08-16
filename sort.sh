#!/bin/sh

if [ $# -eq 1 ]; then
	./merge.sh $1
	sort -nk3 total_data_$1_0
	rm -f total_data_$1_0
elif [ $# -eq 2 ]; then
	./merge.sh $1 $2
	sort -nk2 total_data_$1_$2
	rm -f total_data_$1_$2
fi
