AD=/home/kalle/hack/git/asciidoctor/bin/asciidoctor
#AD=asciidoctor
MAIN=grokking-bitcoin.adoc
OUTPUTDIR=build
ADOC=$(wildcard *.adoc)
BUILDADOC=$(patsubst %.adoc,build/%.adoc,$(ADOC))
.SUFFIXES: .adoc
FULLBOOK=-a chall
ALLCHAPTERS=ch1 ch2 ch3 ch4 ch5 ch6 ch7 ch8 ch9 chweb

all: full chunked

full: setup
#	$(AD) -v -b html5 $(OUTPUTDIR)/$(MAIN) > $(OUTPUTDIR)/grokking-bitcoin.html
	$(AD) -v $(FULLBOOK) -b html5 $(OUTPUTDIR)/$(MAIN) -o $(OUTPUTDIR)/grokking-bitcoin.html

chunked: $(ALLCHAPTERS)

$(ALLCHAPTERS): ch% : setup
	$(AD) -v -r ./hacks/sectnumoffset-treeprocessor.rb -a sectnumoffset=$$(($*-1)) -a ch$* -b html5 $(OUTPUTDIR)/$(MAIN) -o $(OUTPUTDIR)/grokking-bitcoin-$*.html

setup: builddir links $(BUILDADOC)

builddir:
	mkdir -p $(OUTPUTDIR)

links:
	rm -f $(OUTPUTDIR)/images $(OUTPUTDIR)/style
	ln -sfr images $(OUTPUTDIR)
	ln -sfr style $(OUTPUTDIR)

build/%.adoc: $(ADOC)
	hacks/preprocess.sh $*.adoc > $@

clean:
	rm -rf $(OUTPUTDIR)
