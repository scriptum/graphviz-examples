SRC_DOT = $(wildcard *.dot)

TARGETS_PDF = $(SRC_DOT:.dot=.pdf)
TARGETS_PNG = $(SRC_DOT:.dot=.png)
TARGETS_TIF = $(SRC_DOT:.dot=.tiff)
TARGETS = $(TARGETS_PDF) $(TARGETS_PNG) $(TARGETS_TIF)

%.pdf:%.dot Makefile
	dot -Tpdf "$<" -o "$@"

%.tiff:%.pdf Makefile
	convert -density 600 -compress Zip -trim -trim "$<" "$@"

%.png:%.tiff Makefile
	convert -filter Box -resize 25% "$<" "$@"

all: $(TARGETS)

pdf: $(TARGETS_PDF)

png: $(TARGETS_PNG)

tiff: $(TARGETS_TIFF)

clean:
	rm -f $(TARGETS)