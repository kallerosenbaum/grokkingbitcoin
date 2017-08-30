AD=/home/kalle/hack/git/asciidoctor/bin/asciidoctor
MAIN=grokking-bitcoin.adoc
OUTPUTDIR=build
ADOC=$(wildcard *.adoc)
BUILDADOC=$(patsubst %.adoc,build/%.adoc,$(ADOC))
.SUFFIXES: .adoc

html: setup
	$(AD) -b html5 $(OUTPUTDIR)/$(MAIN) > $(OUTPUTDIR)/grokking-bitcoin.html

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
