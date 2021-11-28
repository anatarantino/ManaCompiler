./mana.out < $1 > manaoutput.c
gcc -w manaoutput.c list.c numberList.c -fsanitize=address -o $2
rm manaoutput.c
