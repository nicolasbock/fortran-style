#ifndef __LOGGER_H
#define __LOGGER_H

/** Fatal messages. */
#define FATAL -1

/** A simple information message. */
#define INFO 0

/** The logger function. */
void logger(int level, char *format, ...);

#endif
