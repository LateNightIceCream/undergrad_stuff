#include "daytime_common.h"

#define DEFAULT_DEST_PORT 13
#define DEFAULT_DEST_ADDR "127.0.0.1"

int main(int argc, char *argv[]) {

    SA_IN      dest_addr;
    uint16_t   dest_port; // variable u.U. nicht benötigt
    int        sockfd;
    char       recvline[81];
    char       c;
    int        n;

    memset(&dest_addr, 0, sizeof(dest_addr));

    dest_port = DEFAULT_DEST_PORT;
    inet_aton(DEFAULT_DEST_ADDR, &dest_addr.sin_addr);

    c = 'l';

    //--------------------------------------------------------------------------

    if (argc >= 2) {

        if (!strcmp(argv[1], "h") || !strcmp(argv[1], "--help")) {

            fprintf(stderr,
                    "usage: %s [IPv4] [PORT] [l]\n",
                    argv[0]);

            exit(EXIT_FAILURE);
        }

        if (inet_aton(argv[1], &dest_addr.sin_addr) == 0) {

            inet_aton(DEFAULT_DEST_ADDR, &dest_addr.sin_addr);

            fprintf(stderr,
                    "Invalid IP argument. Using default IP %s.\n",
                    inet_ntoa(dest_addr.sin_addr));
        }

        if (argc > 2) {

            char* endptr;
            dest_port = strtol(argv[2], &endptr, 10);

            if (*endptr != '\0') {

                dest_port = DEFAULT_DEST_PORT;

                fprintf(stderr,
                        "Invalid port argument. Using default port %d.\n",
                        DEFAULT_DEST_PORT);
            }

            if (argc > 3) {
                c = *argv[3];
            }
        }
    }

    dest_addr.sin_family = AF_INET;
    dest_addr.sin_port   = htons(dest_port);

    printf("Port:\t%d\n", dest_port);
    printf("IP:\t%s\n",   inet_ntoa(dest_addr.sin_addr));

    //--------------------------------------------------------------------------

    sockfd = socket(AF_INET, SOCK_STREAM, 0);
    ERR_N_DIE("Socket creation error");

    connect(sockfd, (SA*) &dest_addr, sizeof(dest_addr));
    ERR_N_DIE("Connect error");

    write(sockfd, &c, 1);
    ERR_N_DIE("Write error");

    n = read(sockfd, recvline, 80);
    ERR_N_DIE("Read error");
    recvline[n] = '\0';

    printf("received: %s\n", recvline);

    return EXIT_SUCCESS;
}

//------------------------------------------------------------------------------
// Ausgabe
// > ./cli
/*
   Port: 13
   IP:   127.0.0.1
   Connect error: Connection refused
*/

// > ./cli 127.0.0.1 57007
/*
  Port: 57007
  IP:   127.0.0.1
  received: Wed May 12 11:09:53 2021
*/

// > ./cli 127.0.0.1 57007 g
/*
  Port: 57007
  IP:   127.0.0.1
  received: Wed May 12 09:10:32 2021
*/

// Externe Adresse von https://tf.nist.gov/tf-cgi/servers.cgi
// > ./ cli 129.6.15.28
/*
  Port: 13
  IP:   129.6.15.28
  received:
  59346 21-05-12 09:12:24 50 0 0 851.9 UTC(NIST) *
*/
