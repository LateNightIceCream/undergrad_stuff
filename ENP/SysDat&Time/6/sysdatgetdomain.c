#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <errno.h>

#define ERR_N_DIE(msg) if(errno){perror(msg);exit(EXIT_FAILURE);}
#define MAX_DOMAINNAME_LENGTH 64

int main(int argc, char *argv[]) {

    char domainname[MAX_DOMAINNAME_LENGTH];

    getdomainname(domainname, MAX_DOMAINNAME_LENGTH);
    ERR_N_DIE("getdomainname error");

    return EXIT_SUCCESS;
}

//------------------------------------------------------------------------------
// Ausgabe:
// > ./a.out
// [keine Ausgabe]
