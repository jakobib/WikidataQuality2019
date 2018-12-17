.SUFFIXES: .md .html

TEMPLATE=pandoc-goodies/templates/html5/github/GitHub.html5
FILTER=filter.pl

default: language.html

.md.html:
	pandoc --standalone --css style.css --toc --filter $(FILTER) --template=$(TEMPLATE) $< -o $@
