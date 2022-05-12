#ifndef ECHOTCP_COMMON_H

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <unistd.h>
#include <errno.h>
#include <signal.h>

#define SA    struct sockaddr
#define SA_IN struct sockaddr_in

#define MAXLINE 10

#define ERR_N_DIE(ERR_STR) if(errno) {perror(ERR_STR); exit(EXIT_FAILURE);}

ssize_t writen(int fd, const void* ptr, size_t n);
size_t  readline(int fd, void* ptr, size_t n);

#endif
