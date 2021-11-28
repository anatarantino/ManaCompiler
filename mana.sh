./mana.out < $1 > manaoutput.c
gcc -w manaoutput.c list.c numberList.c -o $2
rm manaoutput.c
