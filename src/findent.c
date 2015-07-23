#include <fcntl.h>
#include <getopt.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <unistd.h>

#include "logger.h"

static void print_help(void)
{
    printf("Usage:\n");
    printf("\n");
    printf("{ -h | --help }   This help\n");
}

int main(int argc, char **argv)
{
    const char *short_options = "h";
    const struct option long_options[] = {
        { "help", no_argument, NULL, 'h' },
        { NULL, 0, NULL, 0 }
    };
    char c;

    while((c = getopt_long(argc, argv, short_options, long_options, NULL)) != -1) {
        switch(c) {
        case 'h':
            print_help();
            return 0;
            break;

        default:
            logger(FATAL, "Unknown command line argument\n");
            return -1;
            break;
        }
    }

    if(optind == argc) {
        logger(FATAL, "Missing input file\n");
    }

    for( ; optind < argc; optind++) {
        /* The parser will not read from a file, but only from
         * standard input. We therefore redirect standard input to our
         * input file. */
        logger(INFO, "Parsing \"%s\"\n", argv[optind]);
        int fd = open(argv[optind], O_RDONLY);
        if(fd < 0) {
            logger(FATAL, "Could not open input file \"%s\"\n", argv[optind]);
        }
        if(dup2(fd, 0) < 0) {
            logger(FATAL, "Could not redirect to standard input\n");
        }
        yyparse();
        close(fd);
    }
}
