// readline.c

#include "echotcp_common.h"

size_t
readline (int fd, void *vptr, size_t maxlen) {

    size_t  n;
    ssize_t readcount;
    char    currentByte;
    char*   ptr;

    ptr = vptr; // Konvertierung

    for (n = 1; n < maxlen; n++) {

again:
        readcount = read(fd, &currentByte, 1);

        if (readcount == 1) {
            *ptr = currentByte;
            ptr++;

            if (currentByte == '\n') {
                break;
            }
        }

        else if (readcount == 0) {
            if (n == 1)
                return 0; // keine Daten gelesen (erste iteration)
            else
                break;    // Daten geschrieben, fertig --> break for
        }

        else {
            if (errno == EINTR) {
                goto again;
            }
            else {
                perror("readline error");
                exit(EXIT_FAILURE);
            }
        }

    }

    *ptr = '\0'; // hier terminieren oder im Aufruf berücksichtigen? maxlen + 1?

    return n;
}
