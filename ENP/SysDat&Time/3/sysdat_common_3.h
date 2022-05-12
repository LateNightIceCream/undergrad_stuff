#ifndef __SYSDAT_COMMON_3_H_
#define __SYSDAT_COMMON_3_H_

#include <stdio.h>
#include <stdlib.h>
#include <errno.h>
#include <sys/types.h>
#include <unistd.h>
#include <pwd.h>

#define DEFAULT_PASSWD_PATH "/etc/passwd"

#define ERR_N_DIE(errmsg) if(errno){perror(errmsg); exit(EXIT_FAILURE);}

void print_passwd (struct passwd* pwdptr);
struct passwd mygetpwuid(uid_t uid);

#endif // __SYSDAT_COMMON_3_H_
