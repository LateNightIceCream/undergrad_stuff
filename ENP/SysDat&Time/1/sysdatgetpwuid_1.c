#include "sysdat_common_1.h"

int main(int argc, char *argv[]) {

    uid_t  uid;
    struct passwd* passwdptr;

    uid = getuid();
    printf("yea\n");
    if (argc >= 2) {

        printf("yea\n");

        char *endptr;
        uid = strtol(argv[1], &endptr, 10);
        ERR_N_DIE("strtol error");
        printf("newa\n");

        if (*endptr != '\0') {
            fprintf(stderr, "usage: %s [uid]", argv[0]);
            exit(EXIT_FAILURE);
        }
    }

    passwdptr = getpwuid(uid);
    ERR_N_DIE("UID error");

    print_passwd(passwdptr);

    return EXIT_SUCCESS;
}

//------------------------------------------------------------------------------
// Ausgabe:
// > ./a.out
/*
User Name:	zamza
Password:	x
User ID:	1000
Group ID:	1000
Comment:	Richie
Home Dir:	/home/zamza
Shell:		/bin/bash
*/
