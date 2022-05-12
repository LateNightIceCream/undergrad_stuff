// writen.c
// write n bytes from ptr to socket fd

#include "echotcp_common.h"

ssize_t
writen (int fd, const void* ptr, size_t n) {

    size_t nleft;
    ssize_t nwritten;

    nleft = n;

    while (nleft > 0) {

        nwritten = write(fd, ptr, nleft);

        if (nwritten <= 0) {
            // Fehlerunterscheidung
            if (errno == EINTR) { // interrupt by signal
                nwritten = 0;
                //continue;
            } else {
                perror("writen error");
                exit(EXIT_FAILURE);
            }
        }

        printf("Written:\t");
        for (int i = 0; i < nwritten; i++) {
            printf("%c", *((char*)(ptr + i)));
        }
        printf("\n");

        // ASCII-Print
        /* for (int i = 0; i < nwritten; i++) { */
        /*     printf("Written:\t%d\n", *((char*)(ptr + i))); */
        /* } */
        /* printf("\n"); */

        nleft -= nwritten;
        ptr   += nwritten;

    }

    return n;
}
