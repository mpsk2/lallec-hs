SOURCE = $(shell find src -name '*.lhs' -o -name '*.hs')
ABS = src/Latte/Parser/Abs.hs

all: lattec
	echo "All"

lattec: $(SOURCE)
	cabal configure
	cabal build
	cp ./dist/build/lattec/lattec .

$(ABS):
	cd src && \
	bnfc -haskell Parser.cf -p Latte --functor -d && \
	cd Latte/Parser && \
	mv Test.hs.bak Test.hs && \
	rm -f *.bak && \
	cd ../../..

clean:
	cabal clean
	rm lattec
