%{
	#include <stdio.h>
	#include <string.h>
	#include <stdlib.h>
	#include "list.h"
	#include "numberList.h"
	#define MAX_LENGTH 15

	int yylex();
	void yyerror(const char *s);
	char type[10]; //aux pointer to save datatype to list node
	list * variables;
	char var[60];
	char aux[60];
	char * tok;
%}

%union{
 char * string;
 int number;
}

/* program */
%token START
%token END
%token DELIMITER

/* data types */
%token TEXT
%token NUMBER

%token INTLIST
%token STLIST

%token <string> STRING
%token <number> INTEGER
%token <string> VARIABLE_NAME
/* constants and delimiters */

/* arithmetic operators */
%token MINUS
%token PLUS
%token MULTIPLY
%token DIVIDE

/* relational operators */
%token LOWER_THAN
%token GREATER_THAN
%token IS_EQUAL
%token NOT_EQUAL

/* logical operators */
%token AND
%token OR
%token NOT

%token TRUE
%token FALSE

/* assignment operators */
%token ASSIGNMENT

/* conditionals */
%token IF
%token ELSE
%token WHILE
%token DO
%token END_IF
%token THEN


/* aux */
%token PRINT_INT
%token PRINT_STRING
%token PRINT_NUM_LIST
%token PRINT_TEXT_LIST
%token STARTS_WITH
%token ADD
%token DELETE
%token NEW
%token NUMBER_FROM_LIST
%token TEXT_FROM_LIST
%token TEXT_TO_LIST
%token NUM_TO_LIST

%type<string> TEXT_OP
%type<string> NUM_LIST_VAR_NAME_OK
%type<string> TEXT_LIST_VAR_NAME_OK
%type<string> DECLARATION
%type<string> TYPE
%type<string> VAR_NAME
%type<string> NUM_LIST_VAR_NAME
%type<string> LIST_VAR_NAME
%type<string> VAR_NAME_OP
%start BEGIN

%%
BEGIN: INIT MAIN FINISH;

/* program */
INIT: START {printf("#include <stdio.h>\n#include <stdlib.h>\n#include <strings.h>\n#include \"list.h\"\n#include \"numberList.h\"\n");printf("int main (void){");};

MAIN: CONDITIONAL MAIN | INSTRUCTION MAIN | {};

FINISH: END {printf("}");};

DECLARATION: NEW TYPE VAR_NAME{
			if(strlen($3) < MAX_LENGTH){
				strcpy(aux,$3);
				if(!find(aux,variables,type)){
					add_to_list($3,$2,variables);
				}else{
					fprintf(stderr, "Variable name '%s' is already defined.\n",$3);
					YYABORT;
				}
			}else{
				fprintf(stderr, "Variable name '%s' is too long.\n",$3);
				yyerror("Variable name error");
			}
			$$=$3;
		}
		| NEW INTLIST NUM_LIST_VAR_NAME STARTS_WITH VAR_NAME_OP{
			if(strlen($3) < MAX_LENGTH){
				if(!find($3,variables,type)){
					strcpy(type,"NUM_LIST");
					add_to_list($3,type,variables);
				}else{
					//TODO error
				}
				printf(" = create_list(%s)",$5);
			}else{
				//TODO error
			}
		}
		| NEW STLIST LIST_VAR_NAME STARTS_WITH VAR_NAME_OP{
			if(strlen($3) < MAX_LENGTH){
				if(!find($3,variables,type)){
					strcpy(type,"NUM_LIST");
					add_to_list($3,type,variables);
				}else{
					//TODO error
				}
				printf(" = create_list(%s)",$5);
			}else{
				//TODO error
			}
		}
		| NEW INTLIST NUM_LIST_VAR_NAME STARTS_WITH INTEGER{
			strcpy(aux, $3);
			$3 = strtok(aux, " ");
			if(strlen($3) < MAX_LENGTH){
				if(!find($3,variables,type)){
					strcpy(type,"NUM_LIST");
					add_to_list($3,type,variables);
				}else{
					//TODO error
				}
				printf(" = create_number_list(%d)",$5);
			}else{
				//TODO error
			}
		}
		| NEW STLIST LIST_VAR_NAME STARTS_WITH STRING{
			strcpy(aux, $3);
			$3 = strtok(aux, " ");
			if(strlen($3) < MAX_LENGTH){
				if(!find($3,variables,type)){
					strcpy(type,"TEXT_LIST");
					add_to_list($3,type,variables);
				}else{
					//TODO error
				}
				printf(" = create_list(%s)",$5);
			}else{
				//TODO error
			}
		}


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
			tok = strtok(aux, " ");
			strcpy(var,$4);
			var[strlen($4)-1] = 0;
			printf("add_to_text_list(%s,%s);",tok,var);
		}
		| ADD VAR_NAME_OP TEXT_TO_LIST TEXT_LIST_VAR_NAME_OK DELIMITER_OP {
			strcpy(aux,$2);
			tok = strtok(aux, " ");
			strcpy(var,$4);
			var[strlen($4)-1] = 0;
			printf("add_to_text_list(%s,%s);",tok,var);
		}
		| ADD INTEGER NUM_TO_LIST NUM_LIST_VAR_NAME_OK DELIMITER_OP {
			strcpy(aux, $4);
			aux[strlen($4)-1]=0;
			printf("add_to_number_list(%d,%s);",$2, aux);
		}
		| ADD VAR_NAME_OP NUM_TO_LIST NUM_LIST_VAR_NAME_OK DELIMITER_OP {
			strcpy(aux,$2);
			tok = strtok(aux, " ");
			strcpy(var, $4);
			var[strlen($4)-1]=0;
			printf("add_to_number_list(%s,%s);",tok, var);
		}
		| DELETE STRING TEXT_FROM_LIST TEXT_LIST_VAR_NAME_OK DELIMITER_OP {
			strcpy(aux, $2);
			tok = strtok(aux, " ");
			strcpy(var, $4);
			var[strlen($4)-1] = 0;
			printf("remove_from_list(%s,%s);",aux,var);
		}
		| DELETE VAR_NAME_OP TEXT_FROM_LIST TEXT_LIST_VAR_NAME_OK DELIMITER_OP {
			strcpy(aux, $2);
			tok = strtok(aux, " ");
			strcpy(var, $4);
			var[strlen($4)-1] = 0;
			printf("remove_from_list(%s,%s);",aux,var);
		}
		| DELETE INTEGER NUMBER_FROM_LIST NUM_LIST_VAR_NAME_OK DELIMITER_OP {
			strcpy(aux, $4);
			aux[strlen($4)-1]=0;
			printf("remove_from_number_list(%d,%s);",$2, aux);
		}
		| DELETE VAR_NAME_OP NUMBER_FROM_LIST NUM_LIST_VAR_NAME_OK DELIMITER_OP {
			strcpy(aux, $2);
			tok = strtok(aux, " ");
			strcpy(var, $4);
			var[strlen($4)-1] = 0;
			printf("remove_from_number_list(%s,%s);",tok, var);
		}


DELIMITER_OP: DELIMITER {printf(";");};
/* conditionals */
CONDITIONAL: WHILE_CONTROL | IF_CONTROL;

WHILE_CONTROL: DO_OP MAIN WHILE_OP BOOL_EXP END_WHILE_OP;

IF_CONTROL: IF_OP BOOL_EXP THEN_OP MAIN END_IF_OP | IF_OP BOOL_EXP THEN_OP MAIN ELSE_OP MAIN END_IF_OP;

IF_OP: IF {printf("if(");};

THEN_OP: THEN {printf("){");};

ELSE_OP: ELSE {printf("}else{");};

END_IF_OP: END_IF {printf("}");};

WHILE_OP: WHILE {printf("}while(");};

DO_OP: DO {printf("do{");};

END_WHILE_OP: DELIMITER {printf(");");};

/* aux */
BOOL_EXP: BOOL_EXP OR_OP BOOL_TERM | BOOL_TERM | NOT_OP BOOL_EXP;

BOOL_TERM: BOOL_TERM AND_OP BOOL_STATE | BOOL_STATE;

BOOL_STATE: BOOLEAN | BOOL_EXP;

BOOLEAN: TRUE_OP | FALSE_OP | COMPARISON;

TRUE_OP: TRUE {printf("1");};

FALSE_OP: FALSE {printf("0");};

COMPARISON: EXP OPERATOR EXP;

OPERATOR: EQ | NEQ | LT | GT;

EXP: TERM | EXP PLUS_OP TERM | EXP MINUS_OP TERM;

TERM: TERM_STATE | TERM DIV_OP TERM_STATE | TERM MULT_OP TERM_STATE | TERM TERM_STATE;

TERM_STATE: NUMBER_OP | VAR_NAME_OK;

NUMBER_OP: INTEGER {printf("%d", $1);};

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

VAR_NAME_OK: VARIABLE_NAME {
	int found = 0;
	if(find($1,variables,type)){
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
	if(find($1,variables,type)){
		found = 1;
	}
	if(!found){
		yyerror("undefined variable");
		fprintf(stderr, "Variable '%s' does not exist.\n",$1);
		YYABORT;
	}else if(strcmp(type,"NUM_LIST")!=0){
		yyerror("Invalid list");
		fprintf(stderr, "Variable '%s' is not a number list.\n",$1);
		YYABORT;
	}
};

TEXT_LIST_VAR_NAME_OK: VARIABLE_NAME {
	int found = 0;
	if(find($1,variables,type)){
		found = 1;
	}
	if(!found){
		yyerror("undefined variable");
		fprintf(stderr,"Variable '%s' does not exist.\n",$1);
		YYABORT;

	}else if(strcmp(type,"TEXT_LIST")!=0){
		yyerror("invalid list");
		fprintf(stderr, "Variable '%s' is not a text list.\n",$1);
		YYABORT;
	}
};

VAR_NAME_OP: VARIABLE_NAME {
	int found = 0;
	if(find($1,variables,type)){
		found = 1;
	}
	if(!found){
		//error. variable not in variables list
		//TODO error
	}
};

VAR_NAME: VARIABLE_NAME {$$ = $1, printf("%s",$$);};

TYPE: TEXT {$$ = "TEXT"; printf("char *");} | NUMBER {$$ = "NUMBER"; printf("int ");};

STRING_ASSIGN: ASSIGN_TEXT TEXT_OP;

ASSIGN_TEXT: ASSIGNMENT {printf("=");};

NUM_ASSIGN: ASSIGN_TEXT EXP;

PRINT_NUM: PRINT_INT_OP PRINT_NUM_END;

PRINT_INT_OP: PRINT_INT {printf("printf(\"");};

PRINT_NUM_END: VARIABLE_NAME {printf("%%d\",%s)",$1);};

PRINT_TEXT: PRINT_TEXT_OP PRINT_TEXT_END;

PRINT_TEXT_OP: PRINT_STRING {printf("printf(");};

TEXT_OP: STRING {printf("%s",$1);};

PRINT_TEXT_END: VARIABLE_NAME {printf("\"%%s\",%s)",$1);}; | TEXT_OP {printf(")");};

LIST_VAR_NAME: VARIABLE_NAME {$$ = $1, printf("list * %s", $$);};

NUM_LIST_VAR_NAME: VARIABLE_NAME {$$ = $1, printf("number_list * %s", $$);};

%%

int yywrap()
{
        return 1;
}

int main(void){
	variables = create_list("");
	yyparse();
	free_list(variables);
}


