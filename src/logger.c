#include <stdarg.h>
#include <stdio.h>

#include "logger.h"

void logger(int level, char *format, ...)
{
    va_list ap;

    va_start(ap, format);
    vprintf(format, ap);;
    va_end(ap);
}
