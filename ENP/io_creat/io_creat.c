#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <errno.h>
#include <string.h>

int
main (int argc, char *argv[]) {

    int   fd;
    int   fileSize;
    char* fileName;

    if (argc != 3) {
        fprintf(stderr, "usage: %s file_path file_size\n", argv[0]);
        exit(EXIT_FAILURE);
    }

    fileName = argv[1];
    fileSize = atoi(argv[2]);

    if (fileSize <= 0) {
        fprintf(stderr, "error: Invalid file size\n");
        exit(EXIT_FAILURE);
    }

    fd = open(fileName, O_CREAT | O_WRONLY | O_TRUNC, S_IRUSR | S_IWUSR);

    if (errno != 0) {
        perror("File open error");
        exit(EXIT_FAILURE);
    }

    lseek(fd, fileSize - 1, SEEK_SET);

    if (errno != 0) {
        perror("File seek error");
        exit(EXIT_FAILURE);
    }

    write(fd, &fd, 1);

    if (errno != 0) {
        perror("File write error");
        exit(EXIT_FAILURE);
    }

    close(fd);

    return EXIT_SUCCESS;
}

// > ls
// a.out io_creat.c
// > ./io_creat.c testfile 1000000000
// > ls
// a.out io_creat.c testfile
