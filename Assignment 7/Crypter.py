#!/usr/bin/env python

from Crypto.Cipher import AES
import sys
import os
import base64

if len(sys.argv) != 2:
	print '[!] Usage: ' + sys.argv[0] + ' <shellcode>'
	sys.exit(1)

Shellcode = sys.argv[1]

# encrypt shellcode
BlockSize = 16
Seperation ='{'
Pad = lambda s: s + (BlockSize - len(s) % BlockSize) * Seperation
Encode = lambda c, s: base64.b64encode(c.encrypt(Pad(s)))
Key = '_@ihack4falafel_'
print 'Encryption Key     : ' + Key
Cipher = AES.new(Key)
Encoded = Encode (Cipher, Shellcode)
print 'Encrypted Shellcode: ' + Encoded
