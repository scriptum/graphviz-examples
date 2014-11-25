SRC_DOT = $(wildcard *.dot)

TARGETS_PDF = $(SRC_DOT:.dot=.pdf)
TARGETS_PNG = $(SRC_DOT:.dot=.png)
TARGETS_TIF = $(SRC_DOT:.dot=.tiff)
TARGETS = $(TARGETS_PDF) $(TARGETS_PNG) $(TARGETS_TIF)

%.pdf:%.dot
	dot -Tpdf "$^" -o "$@"
	type -p pdfoptimize>/dev/null && pdfoptimize "$@"

%.png:%.pdf
	convert -density 384 -scale 25% -trim -trim "$^" "$@"
	type -p optipng>/dev/null && optipng "$@"

%.tiff:%.pdf
	convert -density 600 -compress Fax -trim -trim "$^" "$@"

all: $(TARGETS)

pdf: $(TARGETS_PDF)

png: $(TARGETS_PNG)

tiff: $(TARGETS_TIFF)

clean:
	rm -f $(TARGETS)