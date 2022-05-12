#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <errno.h>
#include <string.h>

int
main(int argc, char *argv[]) {

    char*       fileName;
    struct stat fileStat;

    if (argc != 2) {
        fprintf(stderr, "usage: %s file_name\n", argv[0]);
        exit(EXIT_FAILURE);
    }

    fileName = argv[1];

    stat(fileName, &fileStat);

    if (errno != 0) {
        perror("error");
        exit(EXIT_FAILURE);
    }

    printf("Blocksize: %d\n", (int)fileStat.st_blksize);

    return EXIT_SUCCESS;
}

// > ./a.out testfile
// AUSGABE:
// Blocksize: 4096
