#!/bin/bash
scriptdir=`dirname $0`
java -Djava.ext.dirs=${scriptdir}/lib AAPDFMaker $1 $2 ${scriptdir}/
