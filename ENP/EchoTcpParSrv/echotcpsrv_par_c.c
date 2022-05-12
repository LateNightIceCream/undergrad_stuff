#include "echotcp_common.h"

#include <signal.h>
#include <wait.h>

#define SRVPORT   0xDEAF
#define SRVIPADDR INADDR_LOOPBACK
#define LISTENQ   5

void str_echo(int connfd);

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

    // c)
    signal(SIGCHLD, SIG_IGN);

    //--------------------------------------------------------------------------

    printf("Port:\t%d\n", SRVPORT);
    printf("IP:\t%s\n",   inet_ntoa(srv_addr.sin_addr));

    while (1) {
        connfd = accept(listenfd, (SA*) NULL, NULL);
        ERR_N_DIE("Connfd error");

        if (fork() == 0) {
            printf("----------------------\n");
            printf("New Client Connection!\n");
            printf("----------------------\n");

            if (fork() == 0) {
                printf("ps:\n");

                char command[] = "ps";
                char *argv_for_program[] = {command, NULL };
                execvp(command, argv_for_program);

                exit(EXIT_SUCCESS);
            }
            wait(NULL);

            str_echo(connfd);
            exit(EXIT_SUCCESS);
        }

        //printf("Parent: Closing connection to Client\n");

        close(connfd);
        ERR_N_DIE("Close error");
    }

    close(listenfd);
    return EXIT_SUCCESS;
}


//------------------------------------------------------------------------------

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

// Ausgabe
// Nach Starten zweier Clients
/*
----------------------
New Client Connection!
----------------------
ps:
    PID TTY          TIME CMD
   6716 pts/0    00:00:00 bash
   7452 pts/0    00:00:00 srv3
   7458 pts/0    00:00:00 srv3
   7459 pts/0    00:00:00 ps
----------------------
New Client Connection!
----------------------
ps:
    PID TTY          TIME CMD
   6716 pts/0    00:00:00 bash
   7452 pts/0    00:00:00 srv3
   7458 pts/0    00:00:00 srv3
   7462 pts/0    00:00:00 srv3
   7463 pts/0    00:00:00 ps
*/

// Nach Beenden und Neustart eines Clients
/*
----------------------
New Client Connection!
----------------------
ps:
    PID TTY          TIME CMD
   6716 pts/0    00:00:00 bash
   7452 pts/0    00:00:00 srv3
   7458 pts/0    00:00:00 srv3
   7554 pts/0    00:00:00 srv3
   7555 pts/0    00:00:00 ps
*/
// --> genau 3 srv2 Prozesse... Server parent und 2x client child
// --> kein Zombieprozess!
// --> Methode mit signal(SIGCHLD, SIG_IGN) funktioniert also auch
//     auf meinem System
