@echo off
REM wine cmd /c demo.bat

REM Windows pipe shellcode example
echo Pipe AES shellcode program
echo | set /p=Hello, World! | ./bin/aes-pipe-shellcode.exe 41414141414141414141414141414141 42424242424242424242424242424242

echo..........
REM Windows decrypt and execute example
echo Decrypt AES and execute program
./bin/decrypt-execute.exe
