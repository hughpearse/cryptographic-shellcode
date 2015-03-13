#!/bin/bash

echo ""
echo "Pipe AES shellcode program"
echo -ne 'Hello, World!' | ./bin/aes-pipe-shellcode 41414141414141414141414141414141 42424242424242424242424242424242
echo ""

echo "Decrypt AES and execute program"
./bin/decrypt-execute
