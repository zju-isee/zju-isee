%{
#include "y.tab.h"
%}
 
%%

[0-9]+"."[0-9]+  { /* match float number first */
	yylval.value.flag = 1;
	yylval.value.float_value = atof(yytext);
	return NUMBER;
	}

[0-9]+   {
	yylval.value.flag = 0;
	yylval.value.int_value = atoi(yytext);
	return NUMBER;
	}

[ \t]    ;   /* skip blank chars */
\n       { return yytext[0]; }
.        { return yytext[0]; }

%%
