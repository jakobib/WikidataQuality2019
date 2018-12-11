.SUFFIXES: .md .html

.md.html:
	pandoc --standalone --toc --css style.css $< -o $@
