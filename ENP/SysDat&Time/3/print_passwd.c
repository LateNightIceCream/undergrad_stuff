#include "sysdat_common_3.h"

void
print_passwd (struct passwd* pwdptr) {
    printf("User Name:\t%s\n", pwdptr->pw_name);
    printf("Password:\t%s\n",  pwdptr->pw_passwd);
    printf("User ID:\t%d\n",   pwdptr->pw_uid);
    printf("Group ID:\t%d\n",  pwdptr->pw_gid);
    printf("Comment:\t%s\n",   pwdptr->pw_gecos);
    printf("Home Dir:\t%s\n",  pwdptr->pw_dir);
    printf("Shell:\t\t%s\n",   pwdptr->pw_shell);
}
