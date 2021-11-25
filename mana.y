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
%token NUMBER; //TODO

%token <string> STRING; //TODO fijarse como declarar variable
%token <number> INTEGER; //TODO mismo que string, fijarse como declarar variable
%token <string> VARIABLE_NAME;
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

%token TRUE;
%token FALSE;

/* assignment operators */
%token ASSIGNMENT;

/* conditionals */
%token IF;
%token ELSE;
%token WHILE;
%token DO;

%start BEGIN;

%%
BEGIN: INIT MAIN FINISH;

/* program */
INIT: START {printf("#include <stdio.h>\n#include <stdlib.h>\n#include <strings.h>\n");printf("int main (void){");};

MAIN: {} | CONDITIONAL MAIN | INSTRUCTION MAIN;

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

CONDITIONAL: WHILE_CONTROL | IF_CONTROL;

WHILE_CONTROL: DO_OP MAIN WHILE_OP BOOL_OP END_WHILE_OP; //TODO COMPLETAR

IF_CONTROL: IF_OP BOOL_EXP THEN_OP MAIN END_IF | IF_OP BOOL_EXP THEN_OP MAIN ELSE_OP MAIN END_IF;

IF_OP: IF {printf("if(");};

ELSE_OP: ELSE {printf("}else{");};

WHILE_OP: WHILE {printf("}while(");};

DO_OP: DO {printf("do{");};

/* aux */

BOOL_EXP: BOOL_EXP | NOT_OP BOOL_EXP | BOOL_EXP OR_OP BOOL_TERM;

BOOL_TERM: BOOL_TERM AND_OP BOOL_STATE | BOOL_STATE;

BOOL_STATE: BOOLEAN | BOOL_EXP;

BOOLEAN: TRUE_OP | FALSE_OP | COMPARISON;

TRUE_OP: TRUE {printf("1");};

FALSE_OP: FALSE {printf("0");};

COMPARISON: EXP OPERATOR EXP;

OPERATOR: EQ | NEQ | AND_OP | OR_OP;

EXP: TERM | EXP PLUS_OP TERM | EXP MINUS_OP TERM;

TERM: TERM_STATE | TERM DIV_OP TERM_STATE | TERM MULT_OP TERM_STATE;

TERM_STATE: NUMBER_OP | VAR_NAME_OK

NUMBER_OP: INTEGER {printf("%d", $1);};

VAR_NAME_OK: //TODO;


