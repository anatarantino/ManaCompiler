%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#define MAX_LENGTH 15

char type[7]; aux vector to save datatype to list node
list * variables;
char var[60];
char aux[60];
char * tok;
%}

/* program */
%token START;
%token END;
%token DELIMITER;

/* data types */
%token TEXT; //TODO
%token NUMBER; //TODO

%token INTLIST;
%token STLIST;

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

/* aux */
%token PRINT_INT;
%token PRINT_STRING;
%token PRINT_NUM_LIST;
%token PRINT_TEXT_LIST;
%token STARTS_WITH;
%token ADD;
%token DELETE;
%token NEW;

%type<string> NUM_LIST_VAR_NAME_OK;
%type<string> TEXT_LIST_VAR_NAME_OK;
%type<string> DECLARATION;
%type<string> TYPE;
%type<string> VAR_NAME;
%type<string> NUM_LIST_VAR_NAME;
%type<string> TEXT_LIST_VAR_NAME;
%token<string> NUMBER_FROM_LIST;
%token<string> TEXT_FROM_LIST;
%token<string> LIST_VAR_NAME;

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

WHILE_CONTROL: DO_OP MAIN WHILE_OP BOOL_EXP END_WHILE_OP; //TODO COMPLETAR

IF_CONTROL: IF_OP BOOL_EXP THEN_OP MAIN END_IF | IF_OP BOOL_EXP THEN_OP MAIN ELSE_OP MAIN END_IF;

IF_OP: IF {printf("if(");};

ELSE_OP: ELSE {printf("}else{");};

WHILE_OP: WHILE {printf("}while(");};

DO_OP: DO {printf("do{");};

END_WHILE_OP: DELIMITER {printf(");");};

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

VAR_NAME_OK: VARIABLE_NAME {
	int found = 0;
	if(find(variables,$1,type)){
		found = 1;
	}
	if(!found){
		//error. variable not in variables list
		//TODO error
	}else{
		printf("%s",$1);
	}
};

NUM_LIST_VAR_NAME_OK: VARIABLE_NAME {
	int found = 0;
	if(find(variables,$1,type)){
		found = 1;
	}
	if(!found){
		//error. variable not in variables list
		//TODO error
	}
	if(strcmp(type, "INTEGERLIST")!=0){
		//error
	}
};

TEXT_LIST_VAR_NAME_OK: VARIABLE_NAME {
	int found = 0;
	if(find(variables,$1,type)){
		found = 1;
	}
	if(!found){
		//error. variable not in variables list
		//TODO error
	}
	if(strcmp(type, "STRINGLIST")!=0){
		//error
	}
};

VAR_NAME_OP: VARIABLE_NAME {
	int found = 0;
	if(find(variables,$1,type)){
		found = 1;
	}
	if(!found){
		//error. variable not in variables list
		//TODO error
	}
};

VAR_NAME: VARIABLE_NAME {$$=$1, printf("%s",$$);};

INSTRUCTION: 	DECLARATION DELIMITER_OP
		| DECLARATION STRING_ASSIGN DELIMITER_OP
		| DECLARATION NUM_ASSIGN DELIMITER_OP
		| VAR_NAME_OK STRING_ASSIGN DELIMITER_OP
		| VAR_NAME_OK NUM_ASSIGN DELIMITER_OP
		| PRINT_TEXT DELIMITER_OP
		| PRINT_NUM DELIMITER_OP
		| PRINT_TEXT_LIST TEXT_LIST_VAR_NAME_OK DELIMITER_OP {
			strcpy(var,$2);
			var[strlen($2)-1] = 0;
			printf("print_list(%s);",var);
		}
		| PRINT_NUM_LIST NUM_LIST_VAR_NAME_OK DELIMITER_OP {
			strcpy(var,$2);
			var[strlen($2)-1] = 0;
			printf("print_number_list(%s);",var);
		}
		| ADD STRING TEXT_TO_LIST TEXT_LIST_VAR_NAME_OK DELIMITER_OP {
			strcpy(aux,$2);
			strcpy(var,$4);
			var[strlen($4)-1] = 0;
			printf("add_to_text_list(%s,%s);",aux,var);
		}
		| ADD NUMBER NUM_TO_LIST NUM_LIST_VAR_NAME_OK DELIMITER_OP {
			strcpy(aux, $2);
			aux[strlen($2)-1]=0;
			printf("add_to_number_list(%d,%s);",$2, aux);
		}
		| DELETE STRING TEXT_FROM_LIST TEXT_LIST_VAR_NAME_OK DELIMITER_OP {
			strcpy(aux, $2);
			strcpy(var, $4);
			var[strlen($4)-1] = 0;
			printf("remove_from_list(%s,%s);",aux,var);
		}
		| DELETE NUMBER NUMBER_FROM_LIST NUM_LIST_VAR_NAME_OK DELIMITER_OP {
			strcpy(aux, $2);
			aux[strlen($2)-1]=0;
			printf("remove_from_number_list(%d,%s);",$2, aux);
		}

DECLARATION: 	NEW TYPE VAR_NAME{
			if(strlen($3) < MAX_LENGTH){
				if(!find(variables,$3,type)){
					strcpy(aux,$2);
					add_to_list($3,aux,symbol_table);
				}else{
					//TODO error
				}
			}else{
				//TODO error
			}
			$$=$3;
		}
		| NEW INTLIST NUM_LIST_VAR_NAME STARTS_WITH VAR_NAME_OP{
			if(strlen($3) < MAX_LENGTH){
				if(!find(variables,$3,type)){
					strcpy(type,"INTEGERLIST");
					add_to_list($3,type,symbol_table);
				}else{
					//TODO error
				}
				prinft(" = create_list(%s)",$5);
			}else{
				//TODO error
			}
		};
		| NEW STLIST LIST_VAR_NAME STARTS_WITH VAR_NAME_OP{
			if(strlen($3) < MAX_LENGTH){
				if(!find(variables,$3,type)){
					strcpy(type,"INTEGERLIST");
					add_to_list($3,type,symbol_table);
				}else{
					//TODO error
				}
				prinft(" = create_list(%s)",$5);
			}else{
				//TODO error
			}
		}


TYPE: TEXT {$$="TEXT"; printf("char *");} | NUMBER {$$="NUMBER"; printf("int ");};

STRING_ASSIGN: ASSIGN_TEXT TEXT_OP;

ASSIGN_TEXT: ASSIGNMENT {printf("=");};

NUM_ASSIGN: ASSIGN_TEXT EXP;

PRINT_NUM: PRINT_INT_OP PRINT_NUM_END;

PRINT_INT_OP: PRINT_INT {printf(\"");};

PRINT_NUM_END: VARIABLE_NAME {printf("\"%%d\",%s)",$1);};

PRINT_TEXT: PRINT_TEXT_OP PRINT_TEXT_END;

PRINT_TEXT_OP: PRINT_STRING {printf("printf(");};

TEXT_OP: STRING {printf($1);};

PRINT_TEXT_END: VARIABLE_NAME {printf("\"%%s\",%s)",$1);}; | TEXT_OP {printf(")");};



