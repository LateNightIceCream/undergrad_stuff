#include "daytime_common.h"

int main(int argc, char *argv[]) {

    SA_IN      dest_addr;
    int        sockfd;
    char       recvline[MAXLINE];
    char       c;
    int        n;

    c = 'l';
    if (argc >= 2) {
        c = *argv[1];
    }

    //--------------------------------------------------------------------------

    memset(&dest_addr, 0, sizeof(dest_addr));
    dest_addr.sin_family = AF_INET;
    dest_addr.sin_port   = htons(DEFAULT_DEST_PORT);
    inet_aton(DEFAULT_DEST_ADDR, &dest_addr.sin_addr);

    printf("Dest Port:\t%d\n", ntohs(dest_addr.sin_port));
    printf("Dest IP:\t%s\n",   inet_ntoa(dest_addr.sin_addr));

    //--------------------------------------------------------------------------

    sockfd = socket(AF_INET, SOCK_DGRAM, 0);
    ERR_N_DIE("Socket creation error");

    connect(sockfd, (SA*) &dest_addr, sizeof(dest_addr));
    ERR_N_DIE("Connect error");

    // d)
    write(sockfd, &c, 1);
    ERR_N_DIE("Send error");

    // d)
    n = read(sockfd, recvline, MAXLINE - 1);
    ERR_N_DIE("Recv error");

    recvline[n] = '\0';

    printf("Received: %s\n", recvline);

    close(sockfd);
    return EXIT_SUCCESS;
}

//------------------------------------------------------------------------------
// Ausgabe Client
// > ./cliwrw
/*
Dest Port: 57007
Dest IP:   127.0.0.1
Received:  Fri May 14 18:25:52 2021
*/

// Ausgabe Server
// > ./srv
/*
clientlen:  16
clientip:   127.0.0.1
clientport: 44225
*/
// funktioniert also auch!
