#!usr/bin/bash

make: grl.y grl.l grlEx
		lex grl.l
		yacc -d grl.y
		gcc lex.yy.c y.tab.c -o grl.out
		./grl.out < grlEx > grlEx.dot
		dot -Tps grlEx.dot -o grlEx.ps

clean:
		rm -f grl.out grlEx.dot grlEx.ps lex.yy.c y.tab.c y.tab.h
