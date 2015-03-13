all: wine linux

wine: wine-libs wine-decrypt-execute wine-pipe-shellcode

linux: linux-libs linux-decrypt-execute linux-pipe-shellcode

wine-libs: ./include/aes.c
	wine gcc.exe -c -o ./lib/aes.wine.o ./include/aes.c

linux-libs: ./include/aes.c
	gcc -c -o ./lib/aes.linux.o ./include/aes.c

linux-decrypt-execute: src/decrypt-execute.c
	gcc -I./include src/decrypt-execute.c ./lib/aes.linux.o -o ./bin/decrypt-execute

linux-pipe-shellcode: src/aes-pipe-shellcode.c
	gcc -I./include src/aes-pipe-shellcode.c ./lib/aes.linux.o -o ./bin/aes-pipe-shellcode

wine-decrypt-execute: src/decrypt-execute.c
	wine gcc.exe -I./include src/decrypt-execute.c ./lib/aes.wine.o -o ./bin/decrypt-execute.exe

wine-pipe-shellcode: src/aes-pipe-shellcode.c
	wine gcc.exe -I./include src/aes-pipe-shellcode.c ./lib/aes.wine.o -o ./bin/aes-pipe-shellcode.exe

clean:
	rm ./bin/*
	rm ./lib/*
