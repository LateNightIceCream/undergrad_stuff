#include <stdio.h>

#define MAXLINE 8000


int main(int argc, char *argv[]) {

    char* buffer;

    //while (fgets(sendline, MAXLINE, stdin) != NULL) {
    int i = 0;
    unsigned long int n = 0;
    getline(&buffer, &n, stdin);

    while (buffer[i] != '\0') {
        i++;
    }

    printf("chars got: %d\n", i);

    return 0;
}
