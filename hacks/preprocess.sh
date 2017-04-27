#!/bin/bash

##########################################
# This script is a hack to work around
# quirks in asciidoctor, for example
# that attribute substitutions don't work
# within brackets.
#
# The script looks for comments
# //bash <function> <arg1> <arg2> ...
# 
# And replaces that comment with the
# returned value from the call
# <function> <arg1> <arg2>
# where <function> must be a function
# of this file
###########################################

# This is the file to preprocess
file=$1

function web-resource {
	if [ "x" == "x$WEB_RESOURCE_ID" ]; then
		WEB_RESOURCE_ID=0
	fi
	WEB_RESOURCE_ID=$((WEB_RESOURCE_ID+1))
	label="Web resource $WEB_RESOURCE_ID"
	echo "[[web-$1,$label]]"
	echo "$label:: {resource-url}/$1"
}
export -f web-resource


while read -r line
do
	if [[ "$line" == //bash* ]]; then
		${line:7}
	else 
		echo "$line"
	fi
done < "$file"
