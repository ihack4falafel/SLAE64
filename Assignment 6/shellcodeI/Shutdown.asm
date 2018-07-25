; int reboot(int magic, int magic2, int cmd, void *arg)
; rax=169, rdi=0xfee1dead, rsi=0x28121969, rdx=0x4321fedc

global _start

section .text

_start:
	add al, 0xa9
	mov edi, 0x7F70EF56
	shl rdi, 0x1
	inc edi
	mov edx, 0x28121969
	mov esi, 0x4321fedc
	xchg rdx, rsi
	syscall
