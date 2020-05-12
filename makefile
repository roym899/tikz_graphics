TEX_FILE_PATHS := $(wildcard */*.tex)
TEX_FILES = $(notdir $(TEX_FILE_PATHS))
TEX_DIRS = $(dir $(TEX_FILE_PATHS))
PNG_FILES = $(patsubst %.tex, %.png, $(TEX_FILES))
PNG_FILE_PATHS = $(addprefix build/, $(PNG_FILES))

$(info TEX_FILE_PATHS="$(TEX_FILE_PATHS)")
$(info TEX_FILES="$(TEX_FILES)")
$(info PNG_FILES="$(PNG_FILES)")
$(info PNG_FILE_PATHS="$(PNG_FILE_PATHS)")
$(info TEX_DIRS="$(TEX_DIRS)")

# SRC_DIR := .../src
# pngs =  build/arm_environment_collision.png
# $(pngs): build/%.png : figures/%.tex
# 	-rm -f build/$*.aux build/$*.log build/$*.out build/$*.sta
# 	pdflatex -halt-on-error  --output-directory=build $<
# 	-rm -f build/$*.aux build/$*.log build/$*.out build/$*.sta
# 	pdftoppm -png -r 600 build/$*.pdf >build/$*.png

# -rm -f build/$*.aux build/$*.log build/$*.out build/$*.sta
# pdflatex -halt-on-error  --output-directory=build $<
# -rm -f build/$*.aux build/$*.log build/$*.out build/$*.sta
# pdftoppm -png -r 600 build/$*.pdf >build/$*.png

all: $(PNG_FILE_PATHS)

$(PNG_FILE_PATHS):
	@-mkdir -p build 2> /dev/null
	@-mkdir -p previews 2> /dev/null
	@rm -f $(basename $@).aux $(basename $@).fdb_latexmk $(basename $@).fls $(basename $@).log $(basename $@).sta $(basename $@).out $(basename $@).blg $(basename $@).bbl $(basename $@).toc
	pdflatex -halt-on-error --output-directory=build $<
	@rm -f $(basename $@).aux $(basename $@).fdb_latxmk $(basename $@).fls $(basename $@).log $(basename $@).sta $(basename $@).out $(basename $@).blg $(basename $@).bbl $(basename $@).toc
	pdftoppm -png -r 600 $(basename $@).pdf >$(basename $@).png
	pdftoppm -png -r 100 $(basename $@).pdf >previews/$(basename $(notdir $@)).png

$(foreach x,$(join $(addsuffix :,$(PNG_FILE_PATHS)),$(TEX_FILE_PATHS)),$(eval $x))