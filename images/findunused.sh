#!/bin/bash

imagesrcdir=`dirname $0`
docdir=$imagesrcdir/..
imagedstdir=$docdir/build/images

for chdir in `find $imagesrcdir -type d -and \( -name "app*" -or -name "ch*" \)`; do
    for file in `ls $imagedstdir/$chdir`; do
	grep -q "{imagedir}/$file\\[" $docdir/$chdir*.adoc
	if [ $? != 0 ] ; then
	    echo $chdir/$file
	fi
    done
done
