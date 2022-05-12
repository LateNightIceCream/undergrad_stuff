#include <stdio.h>
#include <stdlib.h>
#include <sys/utsname.h>
#include <errno.h>

#define ERR_N_DIE(msg) if(errno){perror(msg);exit(EXIT_FAILURE);}

void
print_utsname (struct utsname uname) {

    printf("Sysname:\t%s\n",  uname.sysname);
    printf("Nodename:\t%s\n", uname.nodename);
    printf("Release:\t%s\n",  uname.release);
    printf("Version:\t%s\n",  uname.version);
    printf("Machine:\t%s\n",  uname.machine);

#ifdef _GNU_SOURCE
    printf("Domainname:\t%s\n", uname.domainname);
#else
    printf("Domainname:\t%s\n", uname.__domainname); //?
#endif

}

int
main(int argc, char *argv[]) {

    struct utsname kernelinfo;

    uname(&kernelinfo);
    ERR_N_DIE("uname error");

    print_utsname(kernelinfo);

    return EXIT_SUCCESS;
}

//------------------------------------------------------------------------------
// Ausgabe:
// > ./a.out
/*
Sysname:	Linux
Nodename:	omega
Release:	5.11.16-178.current
Version:	#1 SMP PREEMPT Tue Apr 27 11:38:11 UTC 2021
Machine:	x86_64
*/

// Vergleich:
// > uname -a
// Linux omega 5.11.16-178.current #1 SMP PREEMPT Tue Apr 27 11:38:11 UTC 2021 x86_64 GNU/Linux
