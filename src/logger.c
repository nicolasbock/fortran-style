#include <stdarg.h>
#include <stdio.h>
#include <stdlib.h>

#include "logger.h"

void logger(const int level, const char *format, ...)
{
    va_list ap;

    va_start(ap, format);
    if(vprintf(format, ap) < 0) {
        printf("[logger] error printing\n");
        exit(-1);
    }
    va_end(ap);

    if(level == FATAL) {
        exit(-1);
    }
}
