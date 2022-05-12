#include "daytime_common.h"

#define DEFAULT_DEST_PORT 0xDEAF
#define DEFAULT_DEST_ADDR "127.0.0.1"

#define CLI_PORT 0xBEEF

int main(int argc, char *argv[]) {

    SA_IN          dest_addr;
    SA_IN          cli_addr; // a)
    int            sockfd;
    char           recvline[MAXLINE];
    struct timeval timeout;
    char           c;
    int            n;

    timeout.tv_sec  = UDP_RECV_TIMEOUT_SEC;
    timeout.tv_usec = 0;

    c = 'l';
    if (argc > 2) {
        c = *argv[2];
    }

    //--------------------------------------------------------------------------
    memset(&dest_addr, 0, sizeof(dest_addr));
    dest_addr.sin_family = AF_INET;
    dest_addr.sin_port   = htons(DEFAULT_DEST_PORT);
    inet_aton(DEFAULT_DEST_ADDR, &dest_addr.sin_addr);

    // a)
    memset(&cli_addr, 0, sizeof(cli_addr));
    cli_addr.sin_family       = AF_INET;
    cli_addr.sin_port         = htons(CLI_PORT);
    cli_addr.sin_addr.s_addr  = htonl(INADDR_ANY);

    printf("Dest Port:\t%d\n", DEFAULT_DEST_PORT);
    printf("Dest IP:\t%s\n",   inet_ntoa(dest_addr.sin_addr));

    //--------------------------------------------------------------------------

    sockfd = socket(AF_INET, SOCK_DGRAM, 0);
    ERR_N_DIE("Socket creation error");

    // a)
    bind(sockfd, (SA*) &cli_addr, sizeof(cli_addr));
    ERR_N_DIE("Bind error");

    // socket(7), setsockopt(2)
    setsockopt(sockfd, SOL_SOCKET, SO_RCVTIMEO, &timeout, sizeof(timeout));

    sendto(sockfd, &c, 1, 0, (SA*) &dest_addr, sizeof(dest_addr));
    ERR_N_DIE("Sendto error");

    n = recvfrom(sockfd, recvline, MAXLINE - 1, 0, NULL, 0);

    if (errno) {
        if (errno == EAGAIN || errno == EWOULDBLOCK) {
            ERR_N_DIE("Timeout reached");
        }
        ERR_N_DIE("Recvfrom error");
    }

    recvline[n] = '\0';

    printf("Received: %s\n", recvline);

    close(sockfd);
    return EXIT_SUCCESS;
}

//------------------------------------------------------------------------------

// Ausgabe Client
// > ./cliwbind
/*
Dest Port: 57007
Dest IP:   127.0.0.1
Received:  Fri May 14 18:05:19 2021
*/

// Ausgabe Server
// > ./srv
/*
clientlen:  16
clientip:   127.0.0.1
clientport: 48879
*/
