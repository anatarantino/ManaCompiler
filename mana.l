%{
/* TODO declaraciones en C */
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
IF "if"
ELSE "else"
WHILE "while"
DO "repeat:"

%%

/* rules */
{START} {return START;}
{END} {return END}
{DELIMITER} {return DELIMITER}
{TEXT} {return TEXT;}
{STRING} {return yylval.string = yytext; return STRING;}
{NUMBER} {return NUMBER;}
{INTEGER} {return yylval.number=atoi(yytext); return INTEGER;}
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
{VARIABLE_NAME} {yylval.string = yytext; return VARIABLE_NAME;}

[\n] {ECHO; yylineno++;};
[\t] ECHO; //ignore whitespaces
. ECHO
%%

int yyerror(const char *msg){
    fprintf(stderr, "ERROR: %s at line %d\n", msg, yylineno);
    return 0;
}

