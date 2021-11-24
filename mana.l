%{
/* TODO declaraciones en C */
%}

/* definitions */

/* program */
START "start"
END "end"
DELIMITER "."

/* data types */
TEXT "text "
STRING ["][^\n\r]*["]
NUMBER "number "
INTEGER [-]?[0-9]+

/* constants and delimiters */

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
{STRING} {return yylval.string = yytext;}
{NUMBER} {return NUMBER;}
{INTEGER} {return yylval.number=atoi(yytext);}
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
{ASSIGNMENT} {return ASSIGNMENT;}
{IF} {return IF;}
{ELSE} {return ELSE;}
{WHILE} {return WHILE;}
{DO} {return DO;}

[\n] {ECHO; yylineno++;};
[\t] ECHO; //ignore whitespaces
. ECHO
%%

int yyerror(const char *msg){
    fprintf(stderr, "ERROR: %s at line %d\n", msg, yylineno);
    return 0;
}

