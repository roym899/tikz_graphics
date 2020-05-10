build/prm_1.pdf : build/%.pdf : main.tex
	@-mkdir -p build 2> /dev/null
	@rm -f build/$*.aux build/$*.fdb_latexmk build/$*.fls build/$*.log build/$*.sta build/$*.out build/$*.blg build/$*.bbl build/$*.toc
	@latexmk -halt-on-error -pdf -jobname=build/$*
	@rm -f build/$*.aux build/$*.fdb_latexmk build/$*.fls build/$*.log build/$*.sta build/$*.out build/$*.blg build/$*.bbl build/$*.toc
