#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h>

// aus process_env3
int printEnvValue (char* envar) {

    char* envValue = getenv(envar);

    if (envValue == NULL) {
        printf("%s does not exist\n", envar);
        return -1;
    }

    printf("%s has the value %s\n", envar, envValue);

    return 0;
}

int main(int argc, char *argv[]) {

    // ENV-Var setzen und erstellen, falls sie nicht existiert.
    // falls sie existiert -> nicht überschreiben
    printf("setenv(), don't overwrite\n");
    printEnvValue("SHELL");
    setenv("SHELL", "/bin/zsh", 0);
    printEnvValue("SHELL");

    printf("\n");

    // ENV-Var setzen und erstellen, falls sie nicht existiert.
    // falls sie existiert -> überschreiben
    printf("setenv(), overwrite\n");
    printEnvValue("SHELL");
    setenv("SHELL", "/bin/zsh", 1);
    printEnvValue("SHELL");

    printf("\n");

    // ENV-Var setzen und erstellen, falls sie nicht existiert.
    // Im Gegensatz zu setenv() nur ein einzelner String als
    // Argument
    printf("putenv()\n");
    printEnvValue("HELLO");
    putenv("HELLO=WORLD");
    printEnvValue("HELLO");

    printf("\n");

    // Entfernt eine bestimmte ENV-Var.
    printf("unset()\n");
    putenv("FEED=BEEF");
    printEnvValue("FEED");
    unsetenv("FEED");
    printEnvValue("FEED");

    printf("\n");

    // Entfernt alle Umgebungsvariablen und setzt extern environ auf NULL
    printf("clearenv()\n");
    clearenv();
    printEnvValue("SHELL");
    printEnvValue("HELLO");

    printf("\n");

    // Umgebungsvariablen sind prozessspezifisch
    if (fork() == 0) {
        printf("Kindprozess:\n\t");
        putenv("CHILDONLY=U18");
        printEnvValue("CHILDONLY");
        return 0;
    } else {
        wait(NULL);
        printf("Vaterprozess:\n\t");
        printEnvValue("CHILDONLY");
    }

    return 0;

    // ./a.out

    // AUSGABE:
    /*
    setenv(), don't overwrite
    SHELL has the value /bin/bash
    SHELL has the value /bin/bash

    setenv(), overwrite
    SHELL has the value /bin/bash
    SHELL has the value /bin/zsh

    putenv()
    HELLO does not exist
    HELLO has the value WORLD

    unset()
    FEED has the value BEEF
    FEED does not exist

    clearenv()
    SHELL does not exist
    HELLO does not exist

    Kindprozess:
        CHILDONLY has the value U18
    Vaterprozess:
        CHILDONLY does not exist
    */
}
