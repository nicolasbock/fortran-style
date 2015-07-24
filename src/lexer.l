%{
#include "parser.h"
%}

ID [a-zA-Z][0-9a-zA-Z]*
NUM [0-9]*[.0-9eEdD+-]*

%%

"program"          { return PROGRAM; }
"module"           { return MODULE; }
"end"              { return END; }
"do"               { return DO; }
"="                { return ASSIGNMENT; }
[ \t\n]
{ID}               { yylval.string = strdup(yytext); return IDENTIFIER; }
{NUM}              { yylval.string = strdup(yytext); return NUMBER; }
