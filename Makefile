.PHONY: clean

all:
	yacc -d -v mana.y
	lex mana.l
	gcc -o mana.out lex.yy.c y.tab.c list.c numberList.c -fsanitize=address -ly
	@echo "Compilation done."

test:
	./mana.out < tests/helloWorld.mana -t > helloWorld.c
	gcc -w helloWorld.c list.c numberList.c -fsanitize=address -o helloWorld.out
	@echo "Tests compilation done."

clean:
	rm -f *.out *.o lex.yy.c y.tab.c y.tab.h

cleanTest:
	rm -f helloWorld.c helloWorld.out
