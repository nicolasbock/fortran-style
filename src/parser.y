%{
#include <stdarg.h>
#include <stdio.h>

/* Turn on debugging. */
int yydebug = 1;

/* The line number from the lexer. */
extern int yylineno;

/* Declare yyerror(). */
void yyerror(char *const message, ...);
%}

/* Turn on locations for better error reporting. */
%locations

%union {
    char *string;
}

%token PROGRAM "program"
%token MODULE "module"
%token END "end"
%token DO "do"
%token ASSIGNMENT "="
%token <string> NUMBER "number literal"
%token <string> IDENTIFIER "identifier"

%start source

%printer { fprintf(yyoutput, "%s", $$); } IDENTIFIER NUMBER

%%

source: /* empty */
| source program
| source module
;

program: PROGRAM IDENTIFIER body END PROGRAM IDENTIFIER
{
    printf("program %s\n", $2);
    printf("end program %s\n", $6);
}
;

body: /* empty */
| body assignemnt
;

module: MODULE module_body END MODULE

module_body: /* empty */

assignemnt: IDENTIFIER ASSIGNMENT NUMBER
;

%%

#define MAX_LENGTH 10000

void yyerror(char *const message, ...)
{
    va_list ap;
    char new_message[MAX_LENGTH];

    va_start(ap, message);
    vsnprintf(new_message, MAX_LENGTH, message, ap);
    va_end(ap);

    fprintf(stderr, "%s on line %d\n", new_message, yylineno-1);
}
