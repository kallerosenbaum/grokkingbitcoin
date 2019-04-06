AD=~/.rvm/gems/ruby-2.6.0/gems/asciidoctor-1.5.7/bin/asciidoctor
BASE_NAME=grokking-bitcoin
MAIN=$(BASE_NAME).adoc
OUTPUTDIR=build
ALLCHAPTERS=ch1 ch2 ch3 ch4 ch5 ch6 ch7 ch8 ch9 ch10 ch11
ALLAPPENDIXES=app1 app2 app3

all: full chunked

full: setup
	$(AD) -v -b html5 $(MAIN) -o $(OUTPUTDIR)/$(BASE_NAME).html

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

clean:
	rm -rf $(OUTPUTDIR)
