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

    int blocksize;

    if (argc != 2) {
        fprintf(stderr, "usage: %s blocksize < input_file > output_file\n", argv[0]);
        exit(EXIT_FAILURE);
    }

    blocksize = atoi(argv[1]);

    if (blocksize <= 0) {
        fprintf(stderr, "error: Invalid blocksize\n");
        exit(EXIT_SUCCESS);
    }

    // Ab Blockgröße 2147483648 = 2^31: Invalid blocksize,
    // da atoi() einen signed integer zurückgibt

    // Mit dieser Methode erscheint ab Blöckgröße 8381387 = 2^23-7221
    // ein Segmentation Fault
    //char buffer[blocksize]; // warum funktioniert das, kein malloc??

    // Bei dieser Methode: Kein Segfault, funktioniert bis Blockgröße
    // 2^31-1 (bis atoi() negativen Wert gibt)
    char* buffer = (char*) malloc(blocksize);

    printf("%d\n", STDIN_FILENO);
    printf("%d\n", STDOUT_FILENO);

    while (read(STDIN_FILENO, buffer, blocksize)) {
        write(STDOUT_FILENO, buffer, blocksize);

        if (errno != 0) {
            perror("error");
        }
    }

    return EXIT_SUCCESS;
}
