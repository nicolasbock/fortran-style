%{
#include "parser.h"
%}

%%

"program"          { return PROGRAM; }
"end[ \t]+program" { return END_PROGRAM; }
[ \t\n]
[^ \t()%]+         { yylval.string = strdup(yytext); return ID; }
