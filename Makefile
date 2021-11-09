CC = gcc
CFLAGS = -Wall
NUTEXCFLAGS = `pkg-config sdl2 --cflags --libs`
NUTEXLIBS = `pkg-config sdl2 --libs`

default: init

all: out/nutex/nutex out/nutshell/nutshell

run: out/nutex/nutex
	./$^

out/nutex/nutex.exe: out/nutex/main.o 
	$(CC) $(CFLAGS) $(NUTEXCFLAGS) $^ -o $@ $(NUTEXLIBS)

out/nutex/main.o: src/nutex/main.c
	$(CC) $(CFLAGS) $(NUTEXCFLAGS) -c $^ -o $@ $(NUTEXLIBS)

out/nutshell/nutshell.exe: out/nutshell/main.o 
	$(CC) $(CFLAGS) $^ -o $@

out/nutshell/main.o: src/nutshell/main.c
	$(CC) $(CFLAGS) -c $^ -o $@

fmt: $(shell find src -name '*.c') $(shell find src -name '*.h')
	indent $^

init: out/nutshell out/nutex

out/nutex: out
	mkdir $@

out/nutshell: out
	mkdir $@

out:
	mkdir $@

clean:
	rm -r out