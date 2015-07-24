%{
#include <stdarg.h>
#include <stdio.h>
#include <string.h>

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

%type <string> program_stmt end_program_stmt execution_part

%start program

%printer { fprintf(yyoutput, "%s", $$); } IDENTIFIER NUMBER

%%

program: /* empty */
       | program program_unit
;

program_unit: main_program
;

main_program: program_stmt execution_part end_program_stmt
{
    printf("program %s\n", $1);
    printf("%s", $2);
    printf("end program %s\n", $1);
}
;

program_stmt: PROGRAM IDENTIFIER { $$ = $2; }
;

end_program_stmt: END { $$ = NULL; }
                | END PROGRAM { $$ = NULL; }
                | END PROGRAM IDENTIFIER { $$ = $3; }
;

execution_part: /* empty */ { $$ = strdup("\n"); }
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
