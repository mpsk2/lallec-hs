all: src/Latte/Parser/Abs.hs
	echo "gen"

src/Latte/Parser/Abs.hs: src/Parser.cf
	cd src && \
	bnfc -haskell Parser.cf -p Latte --functor -d && \
	cd Latte/Parser && \
	mv Test.hs.bak Test.hs && \
	rm *.bak && \
	cd ../../..

