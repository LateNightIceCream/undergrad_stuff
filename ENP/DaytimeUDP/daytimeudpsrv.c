#include "daytime_common.h"

#define SRVPORT   0xDEAF
#define SRVIPADDR INADDR_LOOPBACK

int  init_srv_socket (SA_IN* srvaddr);
void serve_datetime_udp (int srvfd);

int
main(int argc, char *argv[]) {

    SA_IN  srvaddr;
    int    srvfd;

    srvfd = init_srv_socket(&srvaddr);

    while (1) {
        serve_datetime_udp(srvfd);
    }

    return EXIT_SUCCESS;
}

//------------------------------------------------------------------------------

int
init_srv_socket (SA_IN* srvaddr) {

    int srvfd;

    //memset(&(srvaddr), 0, sizeof(srvaddr));
    srvaddr->sin_family      = AF_INET;
    srvaddr->sin_port        = htons(SRVPORT);   // 0 = autom.
    srvaddr->sin_addr.s_addr = htonl(SRVIPADDR); // INADDR_ANY = autom.
    memset(&(srvaddr->sin_zero), 0, 8);

    srvfd = socket(PF_INET, SOCK_DGRAM, 0);
    ERR_N_DIE("Listen socket error");

    bind(srvfd, (SA*) srvaddr, sizeof(SA_IN));
    ERR_N_DIE("Bind error");

    return srvfd;
}

void serve_datetime_udp (int srvfd) {

    time_t    t;
    char      opcode;
	SA_IN     clientaddr;
    socklen_t clientlen;

    clientaddr.sin_family = AF_INET;
    memset(&(clientaddr.sin_zero), 0, 8);

    clientlen = sizeof(clientaddr);
    recvfrom(srvfd, &opcode, 1, 0, (SA*) &clientaddr, &clientlen);
    ERR_N_DIE("Recvfrom error");

    printf("recieved: %c\n", opcode);
    printf("clientlen:\t%d\n", clientlen);
    printf("clientip:\t%s\n", inet_ntoa(clientaddr.sin_addr));
    printf("clientport:\t%d\n", ntohs(clientaddr.sin_port));

    time(&t);

    if (opcode == 'l') {
        // local time
        sendto(srvfd, ctime(&t), 26, 0, (SA*) &clientaddr, clientlen);
    } else {
        // GMT Daytime
        sendto(srvfd, asctime(gmtime(&t)), 26, 0, (SA*) &clientaddr, clientlen);
    }

    ERR_N_DIE("Sendto error");
}
