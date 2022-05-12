#include "daytime_common.h"

#define SRVPORT   0xDEAF //6543       // zuf. port > well known 1024
#define SRVIPADDR INADDR_ANY          // jede/irgendeine Adresse
#define LISTENQ   5                   // backlog (idR max anz. listen-Verbindungen)

int  init_srv_socket (SA_IN* srvaddr);
void handle_connection (int connfd);  // name vllt etwas allgemein?

int
main(int argc, char *argv[]) {

    SA_IN  srvaddr; // Adressstruktur für Server-Socket
    int    listenfd;
    int    connfd;

    listenfd = init_srv_socket(&srvaddr);

    while (1) {
        // Verbindung vom Client entgegennehmen
        connfd = accept(listenfd, (SA*) NULL, NULL);
        ERR_N_DIE("Accept error");

        handle_connection(connfd);

        // connfd schließen
        close(connfd);
        ERR_N_DIE("Close error");
    }

    return EXIT_SUCCESS;
}

//------------------------------------------------------------------------------

int
init_srv_socket (SA_IN* srvaddr) {

    int          listenfd;
    SA_IN        my_addr;
    socklen_t    len;

    listenfd = socket(PF_INET, SOCK_STREAM, 0);
    ERR_N_DIE("Listen socket error");

    // bzero laut manpage deprecated
    //memset(&srvaddr, 0, sizeof(srvaddr));

    /* struct sockaddr_in { */
    /*     short            sin_family;   // e.g. AF_INET */
    /*     unsigned short   sin_port;     // e.g. htons(3490) */
    /*     struct in_addr   sin_addr;     // see struct in_addr, below */
    /*     char             sin_zero[8];  // zero this if you want to */
    /* }; */
    /**/
    /* struct in_addr { */
    /*     unsigned long s_addr;  // load with inet_aton() */
    /* }; */

    srvaddr->sin_family      = AF_INET;
    srvaddr->sin_port        = htons(SRVPORT);   // 0 = autom.
    srvaddr->sin_addr.s_addr = htonl(SRVIPADDR); // INADDR_ANY = autom.
    memset(&(srvaddr->sin_zero), 0, 8);

    // IP-Adresse und Portnummer spezifizieren
    // srvaddr hat typ struct sockaddr_in, kann aber problemlos gecasted werden
    bind(listenfd, (SA *) srvaddr, sizeof(SA_IN));
    ERR_N_DIE("Bind error");

    // Den socket als Listen-Socket konfigurieren
    listen(listenfd, LISTENQ);
    ERR_N_DIE("Listen error");

    bzero(&my_addr, sizeof(my_addr));
	len = sizeof(my_addr);
    char myIP[16];
	getsockname(listenfd, (struct sockaddr *) &my_addr, &len);
	inet_ntop(AF_INET, &my_addr.sin_addr, myIP, sizeof(myIP));

    len = sizeof(my_addr);
    bzero(&my_addr, len);
    getsockname(listenfd, (SA*) &my_addr, &len);

    return listenfd;
}

void handle_connection (int connfd) {

    time_t t;
    char   opcode;

    time(&t);

    read(connfd, &opcode, 1);
    ERR_N_DIE("Read error");

    if (opcode == 'l') {
        // local time
        write(connfd, ctime(&t), 26);
    } else {
        // GMT Daytime
        write(connfd, asctime(gmtime(&t)), 26);
    }
    // es könnte passieren, dass nicht alle (26) Bytes von write geschrieben
    // werden können, dann wäre es notwendig, den Rest manuell nachzusenden
    // (hier nicht gemacht)
    ERR_N_DIE("Write error");
}

//------------------------------------------------------------------------------
// Ausgabe
// > ./srv
//

// Doppeltes ausführen des gleichen Serverprogrammes
// > ./srv
// > ./srv
// Bind error: Address already in use
