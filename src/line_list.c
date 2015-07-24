#include <assert.h>
#include <stdarg.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>

#include "line_list.h"

void free_lines(struct line_list_t *lines)
{
    struct line_list_t *next;

    while(lines != NULL) {
        next = lines->next;
        free(lines->line);
        free(lines);
        lines = next;
    }
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
