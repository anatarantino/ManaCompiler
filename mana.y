%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

%}

/* program */
%token START;
%token END;
%token DELIMITER;

/* data types */
%token TEXT; //TODO
%token STRING; //TODO fijarse como declarar variable
%token NUMBER; //TODO
%token INTEGER; //TODO mismo que string, fijarse como declarar variable

/* constants and delimiters */

/* arithmetic operators */
%token MINUS;
%token PLUS;
%token MULTIPLY;
%token DIVIDE;

/* relational operators */
%token LOWER_THAN;
%token GREATER_THAN;
%token IS_EQUAL;
%token NOT_EQUAL;

/* logical operators */
%token AND;
%token OR;
%token NOT;

/* assignment operators */
%token ASSIGNMENT;

/* conditionals */
%token IF;
%token ELSE;
%token WHILE;
%token DO;


%%
BEGIN: INIT MAIN FINISH;

/* program */
INIT: START {printf("#include <stdio.h>\n#include <stdlib.h>\n#include <strings.h>\n");printf("int main (void){");};

MAIN:

FINISH: END {printf("}");};

DELIMITER_OP: DELIMITER {printf(";");};

/* arithmetic operators */
MINUS_OP: MINUS {printf("-");};

PLUS_OP: PLUS {printf("+");};

MULT_OP: MULTIPLY {printf("*");};

DIV_OP: DIVIDE {printf("/");};

/* relational operators */
LT: LOWER_THAN {printf("<");};

GT: GREATER_THAN {printf(">");};

EQ: IS_EQUAL {printf("==");};

NEQ: NOT_EQUAL {printf("!=");};

/* logical operators */
AND_OP: AND {printf("&&");};

OR_OP: OR {printf("||");};

NOT_OP: NOT {printf("!");};

/* assignment operators */
ASSIG: ASSIGNMENT {printf("=");};

/* conditionals */
IF_OP: IF {printf("if(");};

ELSE_OP: ELSE {printf("}else{");};

WHILE_OP: WHILE {printf("}while(");};

DO_OP: DO {printf("do{");};


