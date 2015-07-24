%{
#include "parser.h"
%}

NAME [a-zA-Z][a-zA-Z0-9_]*

%%

(?i:program)       { return PROGRAM; }
(?i:module)        { return MODULE; }
(?i:end)           { return END; }
(?i:do)            { return DO; }
(?i:allocate)      { return ALLOCATE; }
"="                { return ASSIGNMENT; }
"("                { return OPEN_PAREN; }
")"                { return CLOSE_PAREN; }
[ \t\n]
{NAME}             { yylval.string = strdup(yytext); return NAME; }
