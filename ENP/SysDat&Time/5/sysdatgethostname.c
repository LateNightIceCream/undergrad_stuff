#define __USE_POSIX
#include <limits.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <errno.h>

#define ERR_N_DIE(msg) if(errno){perror(msg);exit(EXIT_FAILURE);}

int
main(int argc, char *argv[]) {

    char hostname[HOST_NAME_MAX];

    gethostname(hostname, HOST_NAME_MAX);
    ERR_N_DIE("gethostname error");

    printf("Hostname: %s\n", hostname);

    return EXIT_SUCCESS;
}

//------------------------------------------------------------------------------
// Ausgabe:
// > ./a.out
/*
  Hostname: omega
*/
