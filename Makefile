AD=asciidoctor _1.5.8_ -b html5 $(ADOCLANG)
BASE_NAME=grokking-bitcoin
MAIN=$(BASE_NAME).adoc
B=build
ALLCHAPTERS=ch1 ch2 ch3 ch4 ch5 ch6 ch7 ch8 ch9 ch10 ch11
ALLAPPENDIXES=app1 app2 app3
EPS := $(wildcard images/**/*.eps style/images/*.eps)
ALLSVGS := $(patsubst %.eps,build/%.svg,$(EPS))
ALLPNGS := $(patsubst %,$(B)/%,$(wildcard images/**/*.png))
ALLJPGS := $(patsubst %,$(B)/%,$(wildcard images/**/*.jpg))
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
L=$(B)/lang

all: imgs full chunked

full: setup $(ADOCS)
	$(AD) -v $(MAIN) -o $(B)/$(BASE_NAME).html

imgs: $(ALLSVGS) $(ALLPNGS) $(ALLJPGS)

chunked: fm $(ALLCHAPTERS) $(ALLAPPENDIXES)

$(ALLCHAPTERS): ch% : setup
	$(AD) -r ./hacks/sectnumoffset-treeprocessor.rb -a sectnumoffset=$$(($*-1)) -a ch$* $(MAIN) -o $(B)/$(BASE_NAME)-$*.html

$(ALLAPPENDIXES): app% : setup
	$(AD) -r ./hacks/sectnumoffset-treeprocessor.rb -a sectnumoffset=$$(($*-1)) -a app$* $(MAIN) -o $(B)/$(BASE_NAME)-app$*.html

fm:
	$(AD) -a fm -b html5 $(MAIN) -o $(B)/$(BASE_NAME)-fm.html

setup: $(B) links

$(B):
	@mkdir -p $(B)
	@mkdir -p $(B)/images

links:
	rm -rf $(B)/style
	ln -sfr style $(B)

$(B)/%.svg: %.eps
	mkdir -p $(dir $@)
	epstopdf $< $(B)/$*.pdf
	pdf2svg $(B)/$*.pdf $@
	rm $(B)/$*.pdf

$(B)/%.png: %.png
	mkdir -p $(dir $@)
	cp $< $@

$(B)/%.jpg: %.jpg
	mkdir -p $(dir $@)
	cp $< $@

clean:
	rm -rf $(B)

de_DE: % : translate_%
	cp Makefile $(L)/$*
	rm -rf $(L)/$*/images $(L)/$*/style $(L)/$*hacks $(L)/$*/locale
	ln -s ../../../lang/$*/images $(L)/$*/images
	ln -s ../../../lang/locale $(L)/$*/locale
	cp -r style $(L)/$*/style
	cp -r hacks $(L)/$*/hacks
	cd $(L)/$* && $(MAKE) ADOCLANG="-a lang=de" all

translate_%: lang/po4a/po/%.po
	po4a -o noimagetargets=1 lang/po4a/po4a.cfg

pot: lang/po4a/po/grokking-bitcoin.pot

lang/po4a/po/grokking-bitcoin.pot: $(ADOCS)
	po4a-gettextize -M utf-8 -f asciidoc -o noimagetargets=1 $(MASTERS) -p lang/po4a/po/grokking-bitcoin.pot
