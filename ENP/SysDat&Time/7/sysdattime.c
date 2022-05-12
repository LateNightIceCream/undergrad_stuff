#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <errno.h>
#include <time.h>

#define ERR_N_DIE(msg) if(errno){perror(msg);exit(EXIT_FAILURE);}
#define TIME_STR_MAX_LEN 64

void
print_tm_struct (struct tm t) {
    printf("s: %d",   t.tm_sec);
    printf("m: %d",   t.tm_min);
    printf("h: %d",   t.tm_hour);
    printf("d: %d",   t.tm_mday);
    printf("m: %d",   t.tm_mon);
    printf("y: %d",   t.tm_year);
    printf("wd: %d",  t.tm_wday);
    printf("yd: %d",  t.tm_yday);
    printf("dst: %d", t.tm_isdst);
    printf("\n");
}

int main(int argc, char *argv[]) {

    time_t    t;
    char      str[TIME_STR_MAX_LEN];
    struct tm tstruct;

    time(&t);
    ERR_N_DIE("time error");

    printf("time(2) -> time_t:\n\t%ld\n",  t);
    printf("\n");

    tstruct = *gmtime(&t);
    printf("time_t -> gmtime(3):\n\t");
    print_tm_struct(tstruct);
    printf("\n");

    tstruct = *localtime(&t);
    printf("time_t -> localtime(3) -> tm:\n\t");
    print_tm_struct(tstruct);
    printf("\n");

    printf("time_t <- mktime(3) <- tm\n\t%ld\n", mktime(&tstruct));
    printf("\n");

    printf("time_t -> ctime(3) -> str:\n\t%s\n", ctime(&t));
    printf("\n");

    printf("tm -> asctime(3) -> str:\n\t%s\n", asctime(&tstruct));
    printf("\n");

    strftime(str, TIME_STR_MAX_LEN, "%A %b %d %H:%M:%S %Y", &tstruct);
    printf("tm -> strftime(3) -> str:\n\t%s\n", str);
    printf("\n");

    return EXIT_SUCCESS;
}

//------------------------------------------------------------------------------
// Ausgabe:
// > ./a.out
/*
time(2) -> time_t:
	1621103349

time_t -> gmtime(3):
	s: 9m: 29h: 18d: 15m: 4y: 121wd: 6yd: 134dst: 0

time_t -> localtime(3) -> tm:
	s: 9m: 29h: 20d: 15m: 4y: 121wd: 6yd: 134dst: 1

time_t <- mktime(3) <- tm
	1621103349

time_t -> ctime(3) -> str:
	Sat May 15 20:29:09 2021


tm -> asctime(3) -> str:
	Sat May 15 20:29:09 2021


tm -> strftime(3) -> str:
	Saturday May 15 20:29:09 2021
*/
