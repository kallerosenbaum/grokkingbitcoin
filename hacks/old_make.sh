#!/bin/bash

#AD=asciidoctor
AD=/home/kalle/hack/git/asciidoctor/bin/asciidoctor
scriptdir=`dirname $0`
sourcedir=${scriptdir}
outputdir=${sourcedir}/build

mkdir -p ${outputdir}
ln -sr ${sourcedir}/images ${outputdir}
ln -sr ${sourcedir}/style ${outputdir}

for file in ${sourcedir}/*.adoc; do
        basename=`echo $file | sed 's/.*\/\([^\/]*\)\.adoc/\1/'`
	$sourcedir/hacks/preprocess.sh $file >  ${outputdir}/${basename}.adoc
done

file=$outputdir/grokking-bitcoin.adoc
cat $file | $AD -b html5 - > ${outputdir}/grokking-bitcoin.html
#cat $file | asciidoctor-epub3 -D ${outputdir} ${outputdir}/grokking-bitcoin.adoc
#asciidoctor -r ./hacks/multipage-html5-converter.rb -b multipage_html5 --destination-dir=$outputdir $file 



#for file in ${sourcedir}/grokking-bitcoin.adoc; do
#        basename=`echo $file | sed 's/.*\/\([^\/]*\)\.adoc/\1/'`
	# This will generate a docbook xml file from the input
#	cat $file | asciidoctor -T ${TEMPLATEDIR} -b docbook45 - > ${outputdir}/${basename}.xml
#	cat $file | asciidoctor -b docbook5 - > ${outputdir}/${basename}.xml

#	cat $file | asciidoctor -b html5 - > ${outputdir}/${basename}.html
#	asciidoctor -r ./hacks/multipage-html5-converter.rb -b multipage_html5 --destination-dir=$outputdir $file 

#	cat $file | asciidoctor -r asciidoctor-pdf -b pdf - > ${outputdir}/${basename}.pdf

	# This will create a .temp.xml file from the input .xml and
	# generate a pdf from that temp file.
#	${AAMAKEPDFDIR}/makepdf.sh ${outputdir}/$basename.xml ${outputdir}/$basename.pdf
#done
#rm ${scriptdir}/'c:\sw\text.txt'
