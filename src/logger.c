#include <stdarg.h>
#include <stdio.h>
#include <stdlib.h>

#include "logger.h"

static int global_log_level = INFO;

void set_log_level(const int level)
{
    if(level < FATAL || level > DEBUG) {
        printf("[logger] illegal log level\n");
        exit(-1);
    }
    global_log_level = level;
}

void logger(const int level, const char *format, ...)
{
    va_list ap;
    char new_format[1000];

    if(level < FATAL || level > DEBUG) {
        printf("[logger] illegal log level\n");
        exit(-1);
    }

    if(level <= global_log_level) {
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
    }

    if(level == FATAL) {
        exit(-1);
    }
}
