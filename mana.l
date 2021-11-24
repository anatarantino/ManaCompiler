
/* program */
START "start"
END "end"
END_LINE "."

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

int yyerror(const char *msg)
{
    fprintf(stderr, "ERROR: %s at line %d\n", msg, yylineno);
    return 0;
}

