all: build-asm build

build-asm:
	clang -S server.c	

build:
	clang server.c -o server && ./server
