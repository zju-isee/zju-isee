%{
/* 
  the lex program is to count chars, words, lines of a file
*/
#include<stdio.h>
#include<string.h>

int char_num = 0, word_num = 0, line_num = 0;

%}
%%
\n {
    ++line_num;
    ++char_num;
}

[a-zA-Z0-9]+ {
    ++word_num;
    char_num += strlen(yytext);
}

. {
    ++char_num;
}

%%
int main() {
    yylex();
    printf("char_num = %d\nword_num = %d\nline_num = %d\n", char_num, word_num, line_num);
    return 0;
}
