#ifndef DAYTIME_COMMON_H

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <unistd.h>
#include <errno.h>
#include <time.h>


#define SA    struct sockaddr
#define SA_IN struct sockaddr_in // In steht für Internet, nicht input (sonderform von struct sockaddr)


#define ERR_N_DIE(ERR_STR) if(errno) {perror(ERR_STR); exit(EXIT_FAILURE);}


#endif
