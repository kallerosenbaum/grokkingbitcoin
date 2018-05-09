AD=asciidoctor
BASE_NAME=grokking-bitcoin
MAIN=$(BASE_NAME).adoc
OUTPUTDIR=build
ALLCHAPTERS=ch1 ch2 ch3 ch4 ch5 ch6 ch7 ch8 ch9 ch10 ch11 chappendixa chans chweb

all: full chunked

full: setup
	$(AD) -v -b html5 $(MAIN) -o $(OUTPUTDIR)/$(BASE_NAME).html

chunked: $(ALLCHAPTERS)

$(ALLCHAPTERS): ch% : setup
	$(AD) -r ./hacks/sectnumoffset-treeprocessor.rb -a sectnumoffset=$$(($*-1)) -a ch$* -b html5 $(MAIN) -o $(OUTPUTDIR)/$(BASE_NAME)-$*.html

setup: builddir links

builddir:
	@mkdir -p $(OUTPUTDIR)

links:
	@rm -f $(OUTPUTDIR)/images $(OUTPUTDIR)/style
	@ln -sfr images $(OUTPUTDIR)
	@ln -sfr style $(OUTPUTDIR)

clean:
	rm -rf $(OUTPUTDIR)
