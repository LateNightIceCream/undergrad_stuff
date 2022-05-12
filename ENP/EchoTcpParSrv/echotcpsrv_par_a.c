#include "echotcp_common.h"

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

    /* setsockopt(listenfd, SOL_SOCKET, SO_REUSEADDR, &(int){1}, sizeof(int)); */
    /* ERR_N_DIE("setsockopt error"); */

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
// Nach starten zweier Clients:

/*
----------------------
New Client Connection!
----------------------
ps:
    PID TTY          TIME CMD
   6716 pts/0    00:00:00 bash
   6761 pts/0    00:00:00 srv1
   6818 pts/0    00:00:00 srv1
   6819 pts/0    00:00:00 ps
----------------------
New Client Connection!
----------------------
ps:
    PID TTY          TIME CMD
   6716 pts/0    00:00:00 bash
   6761 pts/0    00:00:00 srv1
   6818 pts/0    00:00:00 srv1
   6900 pts/0    00:00:00 srv1
   6901 pts/0    00:00:00 ps
*/

// Nach Beenden und Neustart eines Clients
/*
----------------------
New Client Connection!
----------------------
ps:
    PID TTY          TIME CMD
   6716 pts/0    00:00:00 bash
   6761 pts/0    00:00:00 srv1
   6818 pts/0    00:00:00 srv1
   6900 pts/0    00:00:00 srv1 <defunct>
   6965 pts/0    00:00:00 srv1
   6966 pts/0    00:00:00 ps
*/

// --> defunct... Zombie Prozess!
