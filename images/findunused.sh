#!/bin/bash

dir=`dirname $0`
imagesdir=$dir
docdir=$dir/..

echo "Unused image files"
for chdir in `find $imagesdir -type d -and \( -name "app*" -or -name "ch*" \)`; do
    for file in `ls $imagesdir/$chdir`; do
	grep -q "{imagedir}/$file\\[" $docdir/$chdir*.adoc
	if [ $? != 0 ] ; then
	    echo $chdir/$file
	fi
    done
done
