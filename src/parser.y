%{
#include <assert.h>
#include <stdarg.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/* Turn on debugging. */
int yydebug = 1;

/* The line number from the lexer. */
extern int yylineno;

/* Declare yyerror(). */
void yyerror(char *const message, ...);

struct line_list_t {
    struct line_list_t *next;
    char *line;
};

struct line_list_t * append_line(struct line_list_t *lines,
                                 const struct line_list_t *new_line);
void print_lines(const int indent, struct line_list_t *lines);
%}

/* Turn on locations for better error reporting. */
%locations

%union {
    char *string;
    struct line_list_t *lines;
}

%token PROGRAM "program"
%token MODULE "module"
%token END "end"
%token DO "do"
%token ALLOCATE "allocate"
%token ASSIGNMENT "="
%token OPEN_PAREN "("
%token CLOSE_PAREN ")"
%token <string> NAME "name"

%type <string> program_stmt
%type <string> end_program_stmt
%type <lines> execution_part
%type <lines> executable_construct
%type <lines> action_stmt
%type <lines> allocate_stmt

%start program

%printer { fprintf(yyoutput, "%s", $$); } NAME

%%

program: /* empty */
       | program program_unit
       ;

program_unit: main_program
            ;

main_program: program_stmt execution_part end_program_stmt
              {
                  printf("program %s\n", $1);
                  print_lines(2, $2);
                  printf("end program %s\n", $1);
              }
              ;

program_stmt: PROGRAM NAME { $$ = $2; }
            ;

end_program_stmt: END { $$ = NULL; }
                | END PROGRAM { $$ = NULL; }
                | END PROGRAM NAME { $$ = $3; }
                ;

execution_part: /* empty */ { $$ = NULL; }
              | execution_part executable_construct { $$ = append_line($$, $2); }
              ;

executable_construct: /* empty */ { $$ = NULL; }
                    | executable_construct action_stmt { $$ = append_line($$, $2); }
                    ;

action_stmt: allocate_stmt { $$ = $1; }
           ;

allocate_stmt: ALLOCATE OPEN_PAREN NAME CLOSE_PAREN
               {
                   $$ = calloc(1, sizeof(struct line_list_t));
                   char buffer[1000];
                   snprintf(buffer, 1000, "allocate(%s)", $3);
                   $$->line = strdup(buffer);
               }
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

struct line_list_t * append_line(struct line_list_t *lines,
                                 const struct line_list_t *new_line)
{
    assert(new_line != NULL);

    if(lines == NULL) {
        lines = calloc(1, sizeof(struct line_list_t));
        lines->line = strdup(new_line->line);
    } else {
        struct line_list_t *last_line = lines;
        while(last_line->next != NULL) last_line = last_line->next;
        last_line->next = calloc(1, sizeof(struct line_list_t));
        last_line->next->line = strdup(new_line->line);
    }
    return lines;
}

void print_lines(const int indent, struct line_list_t *lines)
{
    struct line_list_t *line;

    if(lines == NULL) return;
    for(line = lines; line != NULL; line = line->next) {
        char indent_format[100];
        snprintf(indent_format, 100, "%%%ds%%s\n", indent);
        printf(indent_format, " ", line->line);
    }
}
