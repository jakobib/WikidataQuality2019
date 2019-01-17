SOURCES=header-include.tex metadata.yaml slides.md

# requires pandoc >= 2.2 and XeTeX
slides.pdf: $(SOURCES) 
	pandoc -f markdown+smart -t beamer --slide-level=2 \
		--pdf-engine=xelatex -H $(SOURCES) -o $@
