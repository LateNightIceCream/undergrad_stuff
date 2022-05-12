#include "echotcp_common.h"

#define SRVPORT   0xDEAF
#define SRVIPADDR INADDR_LOOPBACK
#define LISTENQ   5

void
str_echo (int connfd) {

    ssize_t n;
    char    recvline[MAXLINE];

    while (1) {
        n = readline(connfd, recvline, MAXLINE);

        printf("Received:\t%s\n", recvline);

        if (n == 0)
            break;

        writen(connfd, recvline, n);
    }

    return;
}

int
main(int argc, char *argv[]) {

    SA_IN      srv_addr;
    int        listenfd;
    int        connfd;

    //--------------------------------------------------------------------------

    memset(&srv_addr, 0, sizeof(srv_addr));
    srv_addr.sin_family      = AF_INET;
    srv_addr.sin_port        = htons(SRVPORT);
    srv_addr.sin_addr.s_addr = htonl(SRVIPADDR);

    listenfd = socket(AF_INET, SOCK_STREAM, 0);
    ERR_N_DIE("Socket creation error");

    bind(listenfd, (SA*) &srv_addr, sizeof(srv_addr));
    ERR_N_DIE("Bind error");

    listen(listenfd, LISTENQ);
    ERR_N_DIE("Listen error");
    //--------------------------------------------------------------------------

    printf("Port:\t%d\n", SRVPORT);
    printf("IP:\t%s\n",   inet_ntoa(srv_addr.sin_addr));

    while (1) {
        connfd = accept(listenfd, (SA*) NULL, NULL);
        ERR_N_DIE("Connfd error");

        str_echo(connfd);

        printf("Closing connection to Client\n");

        close(connfd);
        ERR_N_DIE("Close error");
    }

    close(listenfd);
    return EXIT_SUCCESS;
}
