#ifndef DAYTIME_COMMON_H

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <unistd.h>
#include <errno.h>
#include <time.h>

#define SA    struct sockaddr
#define SA_IN struct sockaddr_in // In steht für Internet, nicht input (sonderform von struct sockaddr)

#define SRVPORT   0xDEAF //6543       // zuf. port > well known 1024
#define SRVIPADDR INADDR_ANY          // jede/irgendeine Adresse
#define LISTENQ   5                   // backlog (idR max anz. listen-Verbindungen)

#define ERR_N_DIE(ERR_STR) if(errno) {perror(ERR_STR); exit(EXIT_FAILURE);}

int  init_srv_socket (SA_IN* srvaddr);
void handle_connection (int connfd);  // name vllt etwas allgemein?

#endif
