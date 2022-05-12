#include "sysdat_common_3.h"
// gehört zur Aufgabe 3, Kapitel 9

// könnte auch struct passwd zurückgeben, dann müsste es aber static sein!
struct passwd mygetpwuid(uid_t uid) {

    struct passwd* pwptr;

    FILE* pwfile = fopen(DEFAULT_PASSWD_PATH, "r");

    do {

        pwptr = fgetpwent(pwfile);

        if (pwptr == NULL) {
            fprintf(stderr, "UID %d not found\n", uid);
            exit(EXIT_FAILURE);
        }

    } while ((pwptr->pw_uid != uid));

    fclose(pwfile);

    return *pwptr;
}
