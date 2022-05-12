#include "sysdat_common_1.h"

int main(int argc, char *argv[]) {

    char*  name;
    struct passwd* passwdptr;

    if (argc < 2) {
        fprintf(stderr, "usage: %s [username]\n", argv[0]);
        exit(EXIT_FAILURE);
    }

    name = argv[1];

    passwdptr = getpwnam(name);
    ERR_N_DIE("getpwnam error");

    print_passwd(passwdptr);

    return EXIT_SUCCESS;
}

//------------------------------------------------------------------------------
// Ausgabe:
// > ./a.out zamza
/*
User Name:	zamza
Password:	x
User ID:	1000
Group ID:	1000
Comment:	Richie
Home Dir:	/home/zamza
Shell:		/bin/bash
*/

// > ./a.out root
/*
User Name:	root
Password:	x
User ID:	0
Group ID:	0
Comment:	root
Home Dir:	/root
Shell:		/bin/bash
*/
