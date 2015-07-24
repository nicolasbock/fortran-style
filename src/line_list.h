#ifndef __LINE_LIST_H
#define __LINE_LIST_H

struct line_list_t {
    struct line_list_t *next;
    char *line;
};

void free_lines(struct line_list_t *lines);
struct line_list_t * append_line(struct line_list_t *lines,
                                 const struct line_list_t *new_line);
void print_lines(const int indent, struct line_list_t *lines);

#endif
