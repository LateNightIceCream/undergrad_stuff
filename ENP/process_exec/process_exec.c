#include <stdio.h>
#include <sys/types.h>
#include <unistd.h>
#include <stdlib.h>
#include <sys/wait.h>


void
print_usage() {
    fprintf(stderr, "Usage: ./a.out <program to exec> <arguments>\n");
    exit(EXIT_FAILURE);
}

int
main(int argc, char *argv[]) {

    char*  command;
    int    wstatus;

    if (argc < 2) {
        print_usage();
    }

    command  = argv[1];

    if (fork() == 0) {

        // execvp() erwartet nullterminierte Liste der Argumente,
        // wobei das erste Element der Befehl selbst ist.
        // argv ist bereits nullterminiert (C Standard 5.1.2.2.1)
        execvp(command, &argv[1]);

        // wird nur im Fehlerfall erreicht
        printf("command \"%s\" not found!\n", command);

        return EXIT_FAILURE;
    }

    wait(&wstatus);
    printf("%d DONE\n", wstatus);

    return EXIT_SUCCESS;
}

// Normaler Befehl
// ./a.out ls

// AUSGABE:
/*
  a.out  process_exec.c  process_exec_old.c
  0 DONE
*/


// Befehl mit Argument(en)
// ./a.out ls --help

// AUSGABE:
/*
  .  ..  a.out  .hello_i_am_hidden  process_exec.c  process_exec_old.c
  0 DONE
*/


// Befehl, der nicht gefunden wird
// ./a.out hello world

// AUSGABE:
/*
  command "hello" not found!
  256 DONE
*/


// Verkettung funktioniert auch :)
// ./a.out ./a.out ls

// AUSGABE:
/*
  a.out  process_exec.c  process_exec_old.c
  0 DONE
  0 DONE
*/
