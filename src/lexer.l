%{
#include "parser.h"
%}

NAME [a-zA-Z][a-zA-Z0-9_]*

%%

"program"          { return PROGRAM; }
"module"           { return MODULE; }
"end"              { return END; }
"do"               { return DO; }
"allocate"         { return ALLOCATE; }
"="                { return ASSIGNMENT; }
"("                { return OPEN_PAREN; }
")"                { return CLOSE_PAREN; }
[ \t\n]
{NAME}             { yylval.string = strdup(yytext); return NAME; }
