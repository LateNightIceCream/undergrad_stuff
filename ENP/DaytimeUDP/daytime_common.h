#ifndef DAYTIME_COMMON_H
#define DAYTIME_COMMON_H

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <unistd.h>
#include <errno.h>
#include <time.h>

#define DEFAULT_DEST_PORT 0xDEAF
#define DEFAULT_DEST_ADDR "127.0.0.1"

#define MAXLINE 4096

#define UDP_RECV_TIMEOUT_SEC 2

#define SA    struct sockaddr
#define SA_IN struct sockaddr_in

#define ERR_N_DIE(ERR_STR) if(errno) {perror(ERR_STR); exit(EXIT_FAILURE);}

#endif
