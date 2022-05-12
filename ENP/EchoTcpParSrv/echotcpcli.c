#include "echotcp_common.h"

#define DEFAULT_DEST_PORT 0xDEAF
#define DEFAULT_DEST_ADDR "127.0.0.1"

void
str_cli (int sockfd) {

    char sendline[MAXLINE];
    char recvline[MAXLINE];

    // einlesen befehl
    while (fgets(sendline, MAXLINE, stdin) != NULL) { // fgets terminiert mit 0

        // senden befehl
        writen(sockfd, sendline, strlen(sendline)); // + 1 '\0' mitsenden?

        // empfangen echo
        if (readline(sockfd, recvline, MAXLINE) == 0) { // MAXLINE-->strlen(sendline) erwartet?
            printf("str_cli: server terminated\n");
            exit(EXIT_FAILURE);
        }

        // Ausgabe echo
        printf("Received:\t%s\n", recvline);

        // ASCII-Code zum Test ausgeben
        for (unsigned long i = 0; i <= strlen(recvline); i++) {
            printf("Received:\t%d\n", recvline[i]);
        }
    }
}

int
main(int argc, char* argv[]) {

    SA_IN      dest_addr;
    uint16_t   dest_port;
    int        sockfd;

    memset(&dest_addr, 0, sizeof(dest_addr));

    dest_port = DEFAULT_DEST_PORT;
    inet_aton(DEFAULT_DEST_ADDR, &dest_addr.sin_addr);

    //--------------------------------------------------------------------------

    if (argc >= 2) {

        if (!strcmp(argv[1], "h") || !strcmp(argv[1], "--help")) {

            fprintf(stderr,
                    "usage: %s [IPv4] [PORT]\n",
                    argv[0]);

            exit(EXIT_FAILURE);
        }

        if (inet_aton(argv[1], &dest_addr.sin_addr) == 0) {

            inet_aton(DEFAULT_DEST_ADDR, &dest_addr.sin_addr);

            fprintf(stderr,
                    "Invalid IP argument. Using default IP %s.\n",
                    inet_ntoa(dest_addr.sin_addr));
        }
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

    //--------------------------------------------------------------------------

    str_cli(sockfd);

    printf("Done\n");

    return EXIT_SUCCESS;
}

//------------------------------------------------------------------------------
// Ausgaben

/* Einfache Verbindung
> ./srv
Port: 57007
IP:   127.0.0.1
... [siehe client-Aufruf]
Received:	abcdefg

Written:	97
Written:	98
Written:	99
Written:	100
Written:	101
Written:	102
Written:	103
Written:	10

> ./cli
Port: 57007
IP:   127.0.0.1
> abcdefg

Written:	97
Written:	98
Written:	99
Written:	100
Written:	101
Written:	102
Written:	103
Written:	10
Written:	0

Received:	abcdefg

*/
//------------------------------------------------------------------------------

/* Mehrfache Verbindung
> ./srv
Port: 57007
IP:   127.0.0.1
...

> ./cli
Port: 57007
IP:   127.0.0.1
> abcdefg
... [siehe Einfache Verbindung]
Written:	abcdefg
Received:	abcdefg

> ./cli
Port: 57007
IP:   127.0.0.1
> hijklmn
Connection Error:
Written:	hijklmn
... (weitere Eingabe, kein Empfang)

Erst nach beenden der Verbindung des ersten Clients (Ctrl+D) kann der zweite
Client eine Verbindung aufbauen. Die eingegebenen Daten beim zweiten Client
werden trotzdem in den Socket geschrieben und bei Verbindung (Beenden des
ersten Clients) ausgesandt.
*/
//------------------------------------------------------------------------------

/* Reduzieren von MAXSIZE auf z.B. 10
Server:
Received:	abcdefghi
Written:	abcdefghi
Received:	jklmno
Written:	jklmno

Client:
abcdefghijklmno
Written:	abcdefghi
Received:	abcdefghi
Received:	97
Received:	98
Received:	99
Received:	100
Received:	101
Received:	102
Received:	103
Received:	104
Received:	105
Received:	0
Written:	jklmno

Received:
Received:	0

Problem: Server funktioniert ohne Probleme (sent == received), aber am
         Client werden nicht alle Zeichen ausgegeben (/empfangen?)
         möglicherweise Problem mit '\0'?
*/
