#include <stdio.h>
#include <stdlib.h>


int printEnvValue (char* envar) {

    char* envValue = getenv(envar);

    if (envValue == NULL) {
        printf("The Environment Variable %s does not exist\n", envar);
        return -1;
    }

    printf("The Environment Variable %s has the value %s\n", envar, envValue);

    return 0;
}

int main(int argc, char* argv[]) {

    char* envList[] = {"HOME", "PATH", "LANG", "LOGNAME", "TERM", "TZ", NULL};

    int i = 0;
    while (envList[i] != NULL) {

        printEnvValue(envList[i]);
        i++;
    }

    return 0;

    // ./a.out

    // AUSGABE:

    /*
    The Environment Variable HOME has the value /home/zamza
    The Environment Variable PATH has the value /sbin:/bin:/usr/sbin:/usr/bin:/snap/bin:/home/zamza/.local/bin
    The Environment Variable LANG has the value en_US.UTF-8
    The Environment Variable LOGNAME has the value zamza
    The Environment Variable TERM has the value xterm-kitty
    The Environment Variable TZ does not exist
    */
}
