##
# DaytimeUDP
#
# @file
# @version 0.1

CC = gcc
CFLAGS = -Wall

SOURCES = $(wildcard *.c)
OBJECTS = $(patsubst %.c, %.o, $(SOURCES))
INCLUDES = $(wildcard *.h)

all: srv cliwbind cliwobind cliwconnect cliwrw

srv: daytimeudpsrv.o
	$(CC) -o $@ $^ $(CFLAGS)

cliwbind: daytimeudpcliwbind.o
	$(CC) -o $@ $^ $(CFLAGS)

cliwobind: daytimeudpcliwobind.o
	$(CC) -o $@ $^ $(CFLAGS)

cliwconnect: daytimeudpcliwconnect.o
	$(CC) -o $@ $^ $(CFLAGS)

cliwrw: daytimeudpcliwrw.o
	$(CC) -o $@ $^ $(CFLAGS)

%.o: %.c $(INCLUDES)
	$(CC) -c -o $@ $< $(CFLAGS)

clean:
	rm *.o

# end
