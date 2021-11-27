%{
    #include "y.tab.h"
    #include <stdlib.h>
    #include <strings.h>

%}

/* definitions */

/* program */
START "start"
END "end"

/* data types */
TEXT "text "
STRING ["][^\n\r]*["]
NUMBER "number "
INTEGER [-]?[0-9]+
VARIABLE_NAME [a-zA-Z]+[_0-9A-Za-z]*
INTLIST "number list "
STLIST "text list "
/* constants and delimiters */
DELIMITER "."

/* arithmetic operators */
MINUS " - "
PLUS " + "
MULTIPLY " * "
DIVIDE " / "

/* relational operators */
LOWER_THAN " < "
GREATER_THAN " > "
IS_EQUAL " is equal to "
NOT_EQUAL " is not equal to "

/* logical operators */
AND " && "
OR " || "
NOT " not "

TRUE "true"
FALSE "false"

/* assignment operators */
ASSIGNMENT " = "

/* conditionals */
IF "if "
ELSE "else"
THEN " then"
WHILE "while"
DO "repeat:"
END_IF "end if"


/* aux */
PRINT_INT "print number: "
PRINT_STRING "print text: "
PRINT_NUM_LIST "print number list: "
PRINT_TEXT_LIST "print text list: "
STARTS_WITH " starts with "
ADD "add "
DELETE "delete "
NUMBER_FROM_LIST " from number list "
TEXT_FROM_LIST " from text list "
NEW "new "
TEXT_TO_LIST " to text list "
NUM_TO_LIST " to number list "

%%


{START} {return START;}
{END} {return END;}
{DELIMITER} {return DELIMITER;}
{TEXT} {return TEXT;}
{STRING} {yylval.string = yytext; return STRING;}
{NUMBER} {return NUMBER;}
{INTEGER} {yylval.number=atoi(yytext); return INTEGER;}
{MINUS} {return MINUS;}
{PLUS} {return PLUS;}
{MULTIPLY} {return MULTIPLY;}
{DIVIDE} {return DIVIDE;}
{LOWER_THAN} {return LOWER_THAN;}
{GREATER_THAN} {return GREATER_THAN;}
{IS_EQUAL} {return IS_EQUAL;}
{NOT_EQUAL} {return NOT_EQUAL;}
{AND} {return AND;}
{OR} {return OR;}
{NOT} {return NOT;}
{TRUE} {return TRUE;}
{FALSE} {return FALSE;};
{ASSIGNMENT} {return ASSIGNMENT;}
{IF} {return IF;}
{ELSE} {return ELSE;}
{WHILE} {return WHILE;}
{DO} {return DO;}
{THEN} {return THEN;}
{END_IF} {return END_IF;}
{VARIABLE_NAME} {yylval.string = yytext; return VARIABLE_NAME;}
{NEW} {return NEW;}
{INTLIST} {return INTLIST;}
{STLIST} {return STLIST;}
{PRINT_INT} {return PRINT_INT;}
{PRINT_STRING} {return PRINT_STRING;}
{PRINT_NUM_LIST} {return PRINT_NUM_LIST;}
{PRINT_TEXT_LIST} {return PRINT_TEXT_LIST;}
{STARTS_WITH} {return STARTS_WITH;}
{ADD} {return ADD;}
{DELETE} {return DELETE;}
{NUMBER_FROM_LIST} {return NUMBER_FROM_LIST;}
{TEXT_FROM_LIST} {return TEXT_FROM_LIST;}
{TEXT_TO_LIST} {return TEXT_TO_LIST;}
{NUM_TO_LIST} {return NUM_TO_LIST;}

[\n] {ECHO; yylineno++;};
[\t] ECHO; //ignore whitespaces
. ECHO;
%%

int yyerror(const char *msg){
    fprintf(stderr, "ERROR: %s at line %d\n", msg, yylineno);
    return 0;
}

