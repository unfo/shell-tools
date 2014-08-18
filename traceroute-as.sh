#!/bin/bash

TARGET=$1
AS_NAMES=$2 # wget http://bgp.potaroo.net/cidr/autnums.html
tracelog=$(mktemp /tmp/trace-$1.XXXXX)
traceroute -a -I $1 | tee -a $tracelog



echo "Path taken: "

while read line
do 
	AS="$(echo -n $line | awk '/AS/ { print $2 }' | awk -F '[' '{ print $2 }' | awk -F ']' '{ print $1 }' )"
	echo -n "$AS "
	if [ "$AS" != "" ]; then
		MATCH="$(echo -n "as=${AS}&")"
		(fgrep -m1 "$MATCH" $AS_NAMES || echo "NOT_FOUND NOT_FOUND NOT_FOUND") | sed 's/<\/a>//' | awk '{ print $3 }' 
	fi
done < $tracelog | column -t | uniq 

rm $tracelog