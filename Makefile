AD=asciidoctor -b html5 $(ADOCLANG)
BASE_NAME=grokking-bitcoin
MAIN=$(BASE_NAME).adoc
B=build
ALLSVGS := $(patsubst %,$(B)/%,$(wildcard images/**/*.svg))
ALLPNGS := $(patsubst %,$(B)/%,$(wildcard images/**/*.png))
ALLJPGS := $(patsubst %,$(B)/%,$(wildcard images/**/*.jpg))
ALLCHAPTERS=ch1 ch2 ch3 ch4 ch5 ch6 ch7 ch8 ch9 ch10 ch11
ALLAPPENDIXES=app1 app2 app3
CHFM=front-matter.adoc
CH01=ch01-introduction-to-bitcoin.adoc
CH02=ch02-hash-functions-and-signatures.adoc
CH03=ch03-addresses.adoc
CH04=ch04-wallets.adoc
CH05=ch05-transactions.adoc
CH06=ch06-the-blockchain.adoc
CH07=ch07-proof-of-work.adoc
CH08=ch08-peer-to-peer-network.adoc
CH09=ch09-transactions-revisited.adoc
CH10=ch10-segregated-witness.adoc
CH11=ch11-bitcoin-upgrades.adoc
CHA1=app1-bitcoin-cli.adoc
CHA2=app2-answers.adoc
CHA3=app3-web-resources.adoc
CHAPTERS=$(CH01) $(CH02) $(CH03) $(CH04) $(CH05) $(CH06) $(CH07) $(CH08) $(CH09) $(CH10) $(CH11)
APPENDIXES=$(CHA1) $(CHA2) $(CHA3)
ADOCS=$(MAIN) $(CHFM) $(CHAPTERS) $(APPENDIXES)
MASTERS := $(patsubst %,-m %,$(ADOCS))
L=$(B)/lang
LANGS := $(patsubst lang/po4a/po/%.po,%,$(wildcard lang/po4a/po/*.po))
SETUP=$(B) $(ALLSVGS) $(ALLPNGS) $(ALLJPGS)
FULL=$(B)/$(BASE_NAME).html
CHUNKED := $(patsubst ch%,$(B)/$(BASE_NAME)-%.html,$(ALLCHAPTERS)) \
           $(patsubst app%,$(B)/$(BASE_NAME)-app%.html,$(ALLAPPENDIXES)) \
           $(B)/$(BASE_NAME)-fm.html
ADCHUNKED = $(AD) -r ./hacks/sectnumoffset-treeprocessor.rb -a sectnumoffset=$$(($*-1))

all: full chunked

full: $(SETUP) $(FULL)

$(FULL): $(ADOCS)
	$(AD) -v $(MAIN) -o $(B)/$(BASE_NAME).html

chunked: $(SETUP) $(CHUNKED)

$(B)/$(BASE_NAME)-fm.html: $(ADOCS)
	$(ADCHUNKED) -a fm $(MAIN) -o $@

$(B)/$(BASE_NAME)-app%.html: $(ADOCS)
	$(ADCHUNKED) -a app$* $(MAIN) -o $@

$(B)/$(BASE_NAME)-%.html: $(ADOCS)
	$(ADCHUNKED) -a ch$* $(MAIN) -o $@

$(ALLSVGS): $(B)/%.svg: %.svg
	@mkdir -p $(dir $@)
	inkscape --export-text-to-path -o $@ $<

$(ALLPNGS): $(B)/%.png: %.png
	mkdir -p $(dir $@)
	cp $< $@

$(ALLJPGS): $(B)/%.jpg: %.jpg
	mkdir -p $(dir $@)
	cp $< $@

$(B):
	@mkdir -p $(B)
	@mkdir -p $(B)/images
	rm -rf $(B)/style
	ln -sfr style $(B)

clean:
	rm -rf $(B)

package: all
	tar --transform=s/build/site/ --exclude=$(B)/lang --exclude=$(B)/site.tar.gz -zchf $(B)/site.tar.gz $(B) 

$(LANGS): % : translate_%
	cp Makefile $(L)/$*
	rm -rf $(L)/$*/images $(L)/$*/style $(L)/$*hacks $(L)/$*/locale
	ln -s ../../../lang/$*/images $(L)/$*/images
	ln -s ../../../lang/locale $(L)/$*/locale
	cp -r style $(L)/$*/style
	cp -r hacks $(L)/$*/hacks
	cd $(L)/$* && $(MAKE) ADOCLANG="-a lang=$*" all

translate_%: lang/po4a/po/%.po
	po4a -o noimagetargets=1 lang/po4a/po4a.cfg

pot: lang/po4a/po/grokking-bitcoin.pot

lang/po4a/po/grokking-bitcoin.pot: $(ADOCS)
	po4a-gettextize -M utf-8 -f asciidoc -o noimagetargets=1 $(MASTERS) -p lang/po4a/po/grokking-bitcoin.pot
