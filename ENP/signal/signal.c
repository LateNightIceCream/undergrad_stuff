#include <stdlib.h>
#include <stdio.h>
#include <signal.h>
#include <errno.h>
#include <unistd.h>
#include <sys/types.h>

#define ERR_N_DIE(msg) if(errno){perror(msg);exit(EXIT_FAILURE);}

void
sigint_handler () {
    fprintf(stderr, "\n^C received, exiting\n");
    exit(EXIT_FAILURE);
}

void
sigterm_handler () {
    fprintf(stderr, "Termination Signal received :)\n");
    exit(EXIT_FAILURE);
}

int
main(int argc, char *argv[]) {

    signal(SIGINT,  sigint_handler); // interrupt from keyboard
    signal(SIGTERM, sigterm_handler);

    ERR_N_DIE("signal error");

    printf("This program will run until you kill it (e.g. with ^C)\n");
    printf("My PID: %d\n", getpid());

    while (1);

    return EXIT_SUCCESS; // never reached
}

//------------------------------------------------------------------------------
// Ausgabe:
// > ./a.out
/*
This program will run until you kill it (e.g. with ^C)
My PID: 5478
> ^C
^C received, exiting
*/

// > ./a.out mit kill 5509 in anderem Terminalfenster
/*
This program will run until you kill it (e.g. with ^C)
My PID: 5509
Termination Signal received :)
*/
