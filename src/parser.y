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
%token END_PROGRAM "end program"
%token <string> ID "identifier"

%start input

%printer { fprintf(yyoutput, "%s", $$); } ID

%%

input: /* empty */
     | PROGRAM ID program_body END_PROGRAM ID
     ;

program_body: /* empty */
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
