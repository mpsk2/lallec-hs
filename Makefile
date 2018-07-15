SOURCE = $(shell find src -name '*.lhs' -o -name '*.hs')
SOURCE_APP = $(shell find app -name '*.lhs' -o -name '*.hs')
SOURCE_TEST = $(shell find test -name '*.lhs' -o -name '*.hs')
ABS = src/Latte/Parser/Abs.hs

all: lattec
	echo "All"

lattec: $(SOURCE) $(SOURCE_APP) $(ABS)
	cabal build
	cp ./dist/build/lattec/lattec .

$(ABS):
	cd src && \
	bnfc -haskell Parser.cf -p Latte --functor -d && \
	cd Latte/Parser && \
	mv Test.hs.bak Test.hs && \
	rm -f *.bak && \
	cd ../../..

test: $(SOURCE) $(SOURCE_APP) $(SOURCE_TEST)
	cabal test

clean:
	cabal clean
	rm lattec
