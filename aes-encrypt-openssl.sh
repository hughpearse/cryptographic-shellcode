#!/bin/bash
#Usage: echo -en 'Hello, World' | ./aes-encrypt-openssl.sh [(key) (iv)]

#echo "\$1 = $1"
if [ -n "$2" ]; then
	key=$1;
	iv=$2;
else
	key=$(openssl rand -hex 16)
	iv=$(openssl rand -hex 16)
fi

echo "Key: $key"
echo "IV: $iv"

read input;
echo "Plaintext: $input"

ciphertext=$(echo -en "$input" | openssl enc -aes-128-cbc -nosalt -e -k $key -iv $iv)
encodedcipher=$(echo -en "$ciphertext" | hexdump -e '16/1 "%02x"')
echo "Ciphertext: $encodedcipher"

byteArr=$(echo -en "$encodedcipher" | hexdump -v -e '"\\\x" 2/1 "%01c"')
echo "Byte Array of Ciphertext: $byteArr"

recovered=$(echo -en "$ciphertext" | openssl enc -aes-128-cbc -nosalt -d -k $key -iv $iv)
echo "Recovered Plaintext: $recovered"
