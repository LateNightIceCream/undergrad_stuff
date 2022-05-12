CC = gcc
CFLAGS = -Wall
FUNCTIONS = writen.c readline.c

all: cli srv1 srv2 srv3

cli:
	$(CC) $(CLFAGS) echotcpcli.c $(FUNCTIONS) -o cli

srv1:
	$(CC) $(CLFAGS) echotcpsrv_par_a.c $(FUNCTIONS) -o $@

srv2:
	$(CC) $(CLFAGS) echotcpsrv_par_b.c $(FUNCTIONS) -o $@

srv3:
	$(CC) $(CLFAGS) echotcpsrv_par_c.c $(FUNCTIONS) -o $@
