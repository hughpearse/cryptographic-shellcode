#include <stdio.h>
#include <string.h>
#include <stdint.h>
#include <stdlib.h>
#define CBC 1
#define ECB 0
#include "aes.h"

#define BLOCKSIZE 16
#define BUFSIZE 1024

int main(int argc, char *argv[]) {
	unsigned char *keyhex;
        unsigned char *ivhex;
	unsigned char key[BLOCKSIZE+1] = { 0 };
	unsigned char iv[BLOCKSIZE+1] = { 0 };
	
	unsigned char plaintext[BUFSIZE] = { 0 };
	unsigned char ciphertext[BUFSIZE] = { 0 };
	int i;

        //parse key from cli args
        if(argc > 1){
        	keyhex = argv[1];
		ivhex = argv[2];
		
		char tmpkey[3] = { 0 };
		for(i = 0; i < BLOCKSIZE; i++) {
			memcpy(tmpkey, keyhex + 2 * i, 2);
			key[i] = (unsigned char)strtol(tmpkey, NULL, 16);
		}

		char tmpiv[3] = { 0 };
                for(i = 0; i < BLOCKSIZE; i++) {
                        memcpy(tmpiv, ivhex + 2 * i, 2);
                        iv[i] = (unsigned char)strtol(tmpiv, NULL, 16);
                }

        } else {
                printf("Title: AES shellcode pipe encryptor\n");
                printf("Usage: echo -ne \"example\" | ./aes-pipe-shellcode [key] [iv]\n");
                exit(0);
        }
	
	printf("Key: ");
        for(i=0; i<strlen(key); i++){
                printf("\\x%02x", key[i]);
        }
	printf("\n");

	printf("IV: ");
	for(i=0; i<strlen(iv); i++){
                printf("\\x%02x", iv[i]);
        }
        printf("\n");

	//parse pipe
        fgets(plaintext, BUFSIZE, stdin);
	printf("Plaintext: %s\n", plaintext);	

	//encrypt text
	AES128_CBC_encrypt_buffer(ciphertext, plaintext, BUFSIZE, key, iv);
	printf("Ciphertext:\n");
	for(i=0; i<sizeof(plaintext); i++){
		printf("\\x%02x", ciphertext[i]);
	}
	printf("\n");

	unsigned char recovered[BUFSIZE] = { 0 };
	AES128_CBC_decrypt_buffer(recovered+0, ciphertext+0,  BLOCKSIZE, key, iv);
	for(i=BLOCKSIZE; i<BUFSIZE; i=i+BLOCKSIZE){
		AES128_CBC_decrypt_buffer(recovered+i, ciphertext+i,  BLOCKSIZE, 0, 0);
	}

	printf("Recovered: %s\n", recovered);
	return 0;
}
