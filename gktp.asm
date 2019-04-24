section .data
msg1 : db "GDTR contents",0x0A
len1 : equ $-msg1
msg2 : db "LDTR contents",0x0A
len2 : equ $-msg2
msg3 : db "IDTR contents",0x0A
len3 : equ $-msg3
msg4 : db "TR contents",0x0A
len4 : equ $-msg4
msg5 : db "MSW contents",0x0A
len5 : equ $-msg5
msg6: db " We are in protected mode",0X0a
len6 : equ $-msg6
msg7 : db ' ',0x0A
len7 : equ $-msg7
msg8 : db "We are not in protected mode",0x0A
len8 : equ $-msg8
msg9 : db ' : ',0x0A
len9 : equ $-msg9


section .bss
gdt : resw 01
	resd 01
ldt : resw 01
idt : resw 01
	resd 01
msw : resw 01
tr : resw 01
result : resw 01

section .text
global _start
_start:

smsw[msw]
sgdt[gdt]
sidt[idt]
sldt[ldt]
str[tr]

mov ax,[msw]
bt ax,0
jc next

mov rax,1
mov rdi,1
mov rsi,msg8
mov rdx,len8
syscall

jmp exit

next:
mov rax,1
mov rdi,1
mov rsi,msg6
mov rdx,len6

;GDT

mov rax,1
mov rdi,1
mov rsi,msg1
mov rdx,len1
syscall

mov bx,word[gdt+4]
call htoa
mov bx,word[gdt+2]
call htoa

mov rax,1
mov rsi,1
mov rdi,msg9
mov rdx,len9
syscall

mov bx,word[gdt]
call htoa

;LDT
mov rax,1
mov rdi,1
mov rsi,msg7
mov rdx,len7
syscall


mov rax,1
mov rdi,1
mov rsi,msg2
mov rdx,len2
syscall

mov bx,word[ldt]
call htoa

;IDT
mov rax,1
mov rdi,1
mov rsi,msg7
mov rdx,len7
syscall

mov rax,1
mov rdi,1
mov rsi,msg3
mov rdx,len3
syscall

mov bx,word[gdt+4]
call htoa
mov bx,word[gdt+2]
call htoa

mov rax,1
mov rsi,1
mov rdi,msg9
mov rdx,len9
syscall

mov bx,word[idt]
call htoa


;MSW
mov rax,1
mov rdi,1
mov rsi,msg7
mov rdx,len7
syscall


mov rax,1
mov rdi,1
mov rsi,msg5
mov rdx,len5
syscall

mov bx,word[msw]
call htoa

;TR
mov rax,1
mov rdi,1
mov rsi,msg7
mov rdx,len7
syscall


mov rax,1
mov rdi,1
mov rsi,msg4
mov rdx,len4
syscall

mov bx,word[tr]
call htoa

exit:
mov rax,60 
mov rdi,0
syscall


htoa:

mov rcx,04
mov rdi,result
dup1:
rol bx,04
mov al,bl
and al,0fh
cmp al,09h
jg p3
add al,30h
jmp p4
p3: 
add al,37h
p4:
mov [rdi],al
inc rdi
loop dup1

mov rax,1
mov rdi,1
mov rsi,result
mov rdx,4

