#ifndef __SYSDAT_COMMON_1_H_
#define __SYSDAT_COMMON_1_H_

#include <stdio.h>
#include <stdlib.h>
#include <errno.h>
#include <sys/types.h>
#include <unistd.h>
#include <pwd.h>

#define ERR_N_DIE(errmsg) if(errno){perror(errmsg); exit(EXIT_FAILURE);}

void print_passwd (struct passwd* pwdptr);

#endif // __SYSDAT_COMMON_1_H_
