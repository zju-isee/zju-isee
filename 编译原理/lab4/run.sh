flex -l calc.l
yacc -d calc.y
gcc -o calc y.tab.c lex.yy.c -ll -lm
./calc < test
