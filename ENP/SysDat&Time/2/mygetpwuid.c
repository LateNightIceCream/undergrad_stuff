#include "sysdat_common_3.h"
//

// könnte auch struct passwd zurückgeben, dann müsste es aber static sein!
struct passwd mygetpwuid(uid_t uid) {

    struct passwd* pwptr;

    setpwent();

    do {
        pwptr = getpwent();

        if (pwptr == NULL) {
            fprintf(stderr, "UID %d not found\n", uid);
            exit(EXIT_FAILURE);
        }

    } while ((pwptr->pw_uid != uid));
    // auf diese Weise funktioniert es nicht?? also ohne if im Block und
    // mit pwptr != NULL in while-Bedingung
    //} while ((pwptr != NULL) || (pwptr->pw_uid != uid));

    endpwent();

    return *pwptr;
}
