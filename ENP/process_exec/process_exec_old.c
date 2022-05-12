#include <stdio.h>
#include <sys/types.h>
#include <unistd.h>
#include <stdlib.h>
#include <sys/wait.h>
#include <string.h>

//#define EXIT_IF_NULL(x) if (!x) {fprintf(stderr, "Some Pointer Problem :)\n"); exit(EXIT_FAILURE);}

void print_usage() {
    fprintf(stderr, "Usage: ./a.out <program to exec>\n");
    exit(EXIT_FAILURE);
}

/*char** generate_exec_argv (char** dest, int argc, char** argv) {

    // kopieren von Befehl + Argumente für exec
    dest = (char**) memcpy(dest, &argv[1], sizeof(char*) * (argc - 1));

    if (!dest) {
        return NULL;
    }

    // Argumentliste muss nullterminiert sein, siehe execvp(3)
    dest[argc-1] = NULL;

    return dest;
}*/

int main(int argc, char *argv[]) {

    char*  command;
    int    wstatus;

    if (argc < 2) {
        print_usage();
    }

    command  = argv[1];

    // Ich habe erst versucht, NULL an argv anzuhängen, damit es
    // in das benötigte Format für exitvp passt und danach heraus-
    // gefunden, dass argv bereits nullterminiert ist... :)

    /*char** execArgv;

    execArgv = (char**) malloc((sizeof(char*) * argc));

    EXIT_IF_NULL(execArgv);
    EXIT_IF_NULL(generate_exec_argv (execArgv, argc, argv));
    */

    // alternative: argv modifizieren (wahrscheinlich nicht so gut)
    /*for (int i = 0; i < argc; i++) {
        argv[i] = argv[i+1];
    }
    argv[argc-1] = NULL;
    */

    if (fork() == 0) {

        // execvp() erwartet nullterminierte Liste der Argumente,
        // wobei das erste Element der Befehl selbst ist.
        // argv ist bereits nullterminiert (C Standard 5.1.2.2.1)
        execvp(command, &argv[1]);

        // wird nur im Fehlerfall erreicht
        printf("command \"%s\" not found!\n", command);
        exit(EXIT_FAILURE);
    }

    wait(&wstatus);

    printf("%d DONE\n", wstatus);

    //free(execArgv);

    return 0;
}

// Verkettung funktioniert auch :)
// ./a.out ./a.out ls
/*


 * */
