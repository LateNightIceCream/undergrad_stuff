#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>

void
print_usage ()
{
    fprintf(stderr, "Usage: ./a.out <task1> ... <taskN>\n");
    exit(EXIT_FAILURE);
}

void
pass_request (pid_t pid_from,
              pid_t pid_to,
              char* request)
{
    printf("Top-Server %d: Auftrag: %s an Sub-Server: %d weitergeben\n",
           pid_from, request, pid_to);
}

void
receive_request (pid_t pid_from,
                 pid_t pid_to,
                 char* request)
{
    printf("Sub-Server %d: Auftrag: %s von Top-Server: %d erhalten\n",
           pid_from, request, pid_to);
}


int
main (int argc, char *argv[])
{
    char* request;
    pid_t pid;

    if (argc < 2) {
        print_usage();
    }

    for (int i = 1; i < argc; i++) {

        request = argv[i];
        pid = fork();

        if (pid == 0) {
            receive_request(getpid(), getppid(), request);
            break;
        }

        pass_request(getpid(), pid, request);

    }

    return EXIT_SUCCESS;
}

// ./a.out hello world
// AUSGABE:
/*
  Top-Server 3980: Auftrag: hello an Sub-Server: 3981 weitergeben
  Sub-Server 3981: Auftrag: hello von Top-Server: 3980 erhalten
  Top-Server 3980: Auftrag: world an Sub-Server: 3982 weitergeben
  Sub-Server 3982: Auftrag: world von Top-Server: 3980 erhalten
*/

// Es kann auch passieren, dass die Reihenfolge nicht stimmt
/*
  Top-Server 4007: Auftrag: hello an Sub-Server: 4008 weitergeben
  Top-Server 4007: Auftrag: world an Sub-Server: 4009 weitergeben
  Sub-Server 4008: Auftrag: hello von Top-Server: 4007 erhalten
  Sub-Server 4009: Auftrag: world von Top-Server: 4007 erhalten
*/
