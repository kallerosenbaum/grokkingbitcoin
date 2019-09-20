AD=asciidoctor
BASE_NAME=grokking-bitcoin
MAIN=$(BASE_NAME).adoc
OUTPUTDIR=build
ALLCHAPTERS=ch1 ch2 ch3 ch4 ch5 ch6 ch7 ch8 ch9 ch10 ch11
ALLAPPENDIXES=app1 app2 app3
EPS := $(wildcard images/**/*.eps style/images/*.eps)
ALLIMGS := $(patsubst %.eps,%.svg,$(EPS))
ADOCS=grokking-bitcoin.adoc \
front-matter.adoc \
ch01-introduction-to-bitcoin.adoc \
ch02-hash-functions-and-signatures.adoc \
ch03-addresses.adoc \
ch04-wallets.adoc \
ch05-transactions.adoc \
ch06-the-blockchain.adoc \
ch07-proof-of-work.adoc \
ch08-peer-to-peer-network.adoc \
ch09-transactions-revisited.adoc \
ch10-segregated-witness.adoc \
ch11-bitcoin-upgrades.adoc \
app1-bitcoin-cli.adoc \
app2-answers.adoc \
app3-web-resources.adoc
MASTERS := $(patsubst %,-m %,$(ADOCS))

all: imgs full chunked

full: setup
	$(AD) -v -b html5 $(MAIN) -o $(OUTPUTDIR)/$(BASE_NAME).html

imgs: $(ALLIMGS)

chunked: fm $(ALLCHAPTERS) $(ALLAPPENDIXES)

$(ALLCHAPTERS): ch% : setup
	$(AD) -r ./hacks/sectnumoffset-treeprocessor.rb -a sectnumoffset=$$(($*-1)) -a ch$* -b html5 $(MAIN) -o $(OUTPUTDIR)/$(BASE_NAME)-$*.html

$(ALLAPPENDIXES): app% : setup
	$(AD) -r ./hacks/sectnumoffset-treeprocessor.rb -a sectnumoffset=$$(($*-1)) -a app$* -b html5 $(MAIN) -o $(OUTPUTDIR)/$(BASE_NAME)-app$*.html

fm:
	$(AD) -a fm -b html5 $(MAIN) -o $(OUTPUTDIR)/$(BASE_NAME)-fm.html

setup: builddir links

builddir:
	@mkdir -p $(OUTPUTDIR)

links:
	@rm -f $(OUTPUTDIR)/images $(OUTPUTDIR)/style
	@ln -sfr images $(OUTPUTDIR)
	@ln -sfr style $(OUTPUTDIR)

%.svg: %.eps
	epstopdf $<
	pdf2svg $*.pdf $*.svg
	rm $*.pdf

clean:
	rm -rf $(OUTPUTDIR)

cleanimgs:
	rm -f images/*/*.svg
	rm -f style/images/periscope.svg

translate:
	po4a lang/po4a/po4a.cfg

pot: lang/po4a/po/grokking-bitcoin.pot

lang/po4a/po/grokking-bitcoin.pot: $(ADOCS)
	po4a-gettextize -M utf-8 -f asciidoc $(MASTERS) -p lang/po4a/po/grokking-bitcoin.pot
