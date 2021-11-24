.PHONY: clean

all:
	yacc -d mana.y
	lex mana.l
	gcc -o mana.out lex.yy.c y.tab.c -ly
	@echo "Compilation done."

clean:
	rm -f *.out *.o lex.yy.c y.tab.c y.tab.h

#test:
