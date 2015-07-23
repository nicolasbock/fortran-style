#include <getopt.h>
#include <stdio.h>
#include <stdlib.h>

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
}
