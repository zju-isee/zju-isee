%{
#include <stdio.h>
#include <ctype.h>
#include <math.h>
%}

%token NUMBER

%union
{
   	struct number {	
	  	int int_value;
	    	float float_value;
	    	int flag; /* 0 for int, 1 for float */
	} value;
}

%type <value> exp NUMBER
%left '+' '-'
%left '*' '/'
%left NEG
%right '^'


%%

input   :
        | input command 
        ;

command : exp '\n' { 
		if($1.flag == 0) printf("%d\n", $1.int_value); 
		else printf("%.1f\n", $1.float_value);
        }
        ;

exp     : NUMBER { $$ = $1; }
        | exp '+' exp { 
		if($1.flag == 1 && $3.flag == 1) {
			$$.flag = 1;
			$$.float_value = $1.float_value + $3.float_value;
		} else if ($1.flag == 1 && $3.flag == 0) {
			$$.flag = 1;
			$$.float_value = $1.float_value + $3.int_value;
		} else if ($1.flag == 0 && $3.flag == 1) {
			$$.flag = 1;
			$$.float_value = $1.int_value + $3.float_value;
		} else {
			$$.flag = 0;
			$$.int_value = $1.int_value + $3.int_value;
		}
	}
        | exp '-' exp { 
		if($1.flag == 1 && $3.flag == 1) {
			$$.flag = 1;
			$$.float_value = $1.float_value - $3.float_value;
		} else if ($1.flag == 1 && $3.flag == 0) {
			$$.flag = 1;
			$$.float_value = $1.float_value - $3.int_value;
		} else if ($1.flag == 0 && $3.flag == 1) {
			$$.flag = 1;
			$$.float_value = $1.int_value - $3.float_value;
		} else {
			$$.flag = 0;
			$$.int_value = $1.int_value - $3.int_value;
		}
	}
        | exp '*' exp { 
		if($1.flag == 1 && $3.flag == 1) {
			$$.flag = 1;
			$$.float_value = $1.float_value * $3.float_value;
		} else if ($1.flag == 1 && $3.flag == 0) {
			$$.flag = 1;
			$$.float_value = $1.float_value * $3.int_value;
		} else if ($1.flag == 0 && $3.flag == 1) {
			$$.flag = 1;
			$$.float_value = $1.int_value * $3.float_value;
		} else {
			$$.flag = 0;
			$$.int_value = $1.int_value * $3.int_value;
		}
	}
        | exp '/' exp { 
		if($1.flag == 1 && $3.flag == 1) {
			$$.flag = 1;
			$$.float_value = $1.float_value / $3.float_value;
		} else if ($1.flag == 1 && $3.flag == 0) {
			$$.flag = 1;
			$$.float_value = $1.float_value / $3.int_value;
		} else if ($1.flag == 0 && $3.flag == 1) {
			$$.flag = 1;
			$$.float_value = $1.int_value / $3.float_value;
		} else {
			$$.flag = 0;
			$$.int_value = $1.int_value / $3.int_value;
		}
	}
        | '-' exp %prec NEG { 
		if($2.flag == 1) {
			$$.flag = 1;
			$$.float_value = -$2.float_value;
		} else {
			$$.flag = 0;
			$$.int_value = -$2.int_value;
		}
	}
	| exp '^' exp { 
		if($1.flag == 1 && $3.flag == 1) {
			$$.flag = 1;
			$$.float_value = pow($1.float_value, $3.float_value);
		} else if ($1.flag == 1 && $3.flag == 0) {
			$$.flag = 1;
			$$.float_value = pow($1.float_value, $3.int_value);
		} else if ($1.flag == 0 && $3.flag == 1) {
			$$.flag = 1;
			$$.float_value = pow($1.int_value, $3.float_value);
		} else {
			$$.flag = 0;
			$$.int_value = pow($1.int_value, $3.int_value);
		}
	}
	| '(' exp ')' { $$ = $2; }
	;

%%

int main()
{
	yyparse();
}
 
int yyerror(char *s)
{
	fprintf(stderr, "%s\n",s);
	return 0;
}
