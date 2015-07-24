#ifndef __LOGGER_H
#define __LOGGER_H

/** Fatal messages. */
#define FATAL -1

/** A simple information message. */
#define INFO 0

/** A debug message. */
#define DEBUG 1

/** Setter for log level. */
void set_log_level(const int level);

/** The logger function. */
void logger(const int level, const char *format, ...);

#endif
