#include "sysdat_common_2.h"

int main(int argc, char *argv[]) {

    uid_t  uid;
    struct passwd passwd;

    uid = getuid();
    if (argc >= 2) {

        char *endptr;
        uid = strtol(argv[1], &endptr, 10);
        ERR_N_DIE("strtol error");

        if (*endptr != '\0') {
            fprintf(stderr, "usage: %s [uid]\n", argv[0]);
            exit(EXIT_FAILURE);
        }
    }

    // hier ein Fehler: UID error: Invalid argument... wieso? */
    /* passwd = *getpwent(); */
    /* ERR_N_DIE("UID error"); */

    passwd = mygetpwuid(uid);
    print_passwd(&passwd);

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

// > ./a.out 0
/*
User Name:	root
Password:	x
User ID:	0
Group ID:	0
Comment:	root
Home Dir:	/root
Shell:		/bin/bash
*/

// > ./a.out 666
/*
UID 666 not found
*/
