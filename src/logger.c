#include <stdarg.h>
#include <stdio.h>
#include <stdlib.h>

#include "logger.h"

void logger(const int level, const char *format, ...)
{
    va_list ap;
    char new_format[1000];

    switch(level) {
    case FATAL:
        snprintf(new_format, 1000, "[FATAL] %s", format);
        break;
    case DEBUG:
        snprintf(new_format, 1000, "[DEBUG] %s", format);
        break;
    default:
        snprintf(new_format, 1000, "%s", format);
        break;
    }

    va_start(ap, format);
    if(vfprintf(stderr, new_format, ap) < 0) {
        printf("[logger] error printing\n");
        exit(-1);
    }
    va_end(ap);

    if(level == FATAL) {
        exit(-1);
    }
}
