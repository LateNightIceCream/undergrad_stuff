#ifndef __SYSDAT_COMMON_2_H_
#define __SYSDAT_COMMON_2_H_

#include <stdio.h>
#include <stdlib.h>
#include <errno.h>
#include <sys/types.h>
#include <unistd.h>
#include <pwd.h>

#define ERR_N_DIE(errmsg) if(errno){perror(errmsg); exit(EXIT_FAILURE);}

void print_passwd (struct passwd* pwdptr);
struct passwd mygetpwuid(uid_t uid);

#endif // __SYSDAT_COMMON_2_H_
