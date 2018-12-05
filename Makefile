.SUFFIXES: .md .html

.md.html:
	pandoc --standalone --css style.css $< -o $@
