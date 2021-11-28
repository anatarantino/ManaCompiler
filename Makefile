.PHONY: clean

all:
	yacc -d -v mana.y
	lex mana.l
	gcc -o mana.out lex.yy.c y.tab.c list.c numberList.c -fsanitize=address -ly
	@echo "Compilation done."

test:
	./mana.out < tests/hello.mana > hello.c
	gcc -w hello.c list.c numberList.c -fsanitize=address -o hello.out

	./mana.out < tests/factorial.mana > factorial.c
	gcc -w factorial.c list.c numberList.c -fsanitize=address -o factorial.out

	./mana.out < tests/greaterNum.mana > greaterNum.c
	gcc -w greaterNum.c list.c numberList.c -fsanitize=address -o greaterNum.out

	./mana.out < tests/textList.mana > textList.c
	gcc -w textList.c list.c numberList.c -fsanitize=address -o textList.out

	./mana.out < tests/numList.mana > numList.c
	gcc -w numList.c list.c numberList.c -fsanitize=address -o numList.out

	@echo "Tests compilation done."

clean:
	rm -f *.out *.o lex.yy.c y.tab.c y.tab.h

cleanTest:
	rm -f hello.c hello.out factorial.c factorial.out greaterNum.c greaterNum.out textList.c textList.out numList.c numList.out