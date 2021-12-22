section .bss
string resb 8
char resb 1
result resb 17

section .data
p1 db "Enter string(8 characters):", 0x0A
p1_len equ $-p1
p2 db "Enter character:", 0x0A
p2_len equ $-p2

section .text
global _start

_start:
    mov eax, 4
    mov ebx, 1
    mov ecx, p1
    mov edx, p1_len
    int 0x80

    mov eax, 3
    mov ebx, 2
    mov ecx, string
    mov edx, 9
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, p2
    mov edx, p2_len
    int 0x80

    mov eax, 3
    mov ebx, 2
    mov ecx, char
    mov edx, 2
    int 0x80

    mov eax, 0
    mov ebx, 0
    mov ecx, 0
    mov edx, 0


cycle:
    mov al, string[ecx]
    cmp al, [char]
    je found
    
    mov result[ecx], al
    inc ecx
    jmp cycle

found:
    mov result[ecx], al
    inc ecx
    mov ebx, ecx
    sub ebx, 2
    mov edx, ecx


cpy_cycle:
    mov al, result[ebx]
    mov result[ecx], al

    inc ecx
    dec ebx
    cmp ebx, 0

    jl finish
    jmp cpy_cycle
    
finish:
    
fin_cpy:
    mov al, string[edx]
    mov result[ecx], al
    inc ecx
    inc edx
    cmp edx, 8
    je end
    jne fin_cpy

end:
    inc ecx
    mov result[ecx], BYTE 0x0A
    inc ecx
    
    mov edx, ecx
    mov eax, 4
    mov ebx, 1
    mov ecx, result
    int 0x80

    mov eax, 1
    mov ebx, 0
    int 0x80 
            


