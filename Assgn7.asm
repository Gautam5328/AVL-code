;Program to write the sorted numbers in ascending
section   .data
	fname: db 'Tejas123.txt',0
	;array db 10h,20h,30h,50h,40h

	msg: db "File opened successfully",0x0A
	len: equ $-msg
	
	msg1: db "The sorted elements are (In Ascending):",0x0A
	len1: equ $-msg1

	msg2: db "Error opening file",0x0A
	len2: equ $-msg2
	
	msg3: db "The sorted element are(In Descending):",0x0A
	len3: equ $-msg3
	
	
section   .bss
	fd: resb 8
	buffer: resb 200
	buf_len: resb 17
	count1: resb 8
	count2: resb 8
%macro scall 4
mov rax,%1
mov rdi,%2
mov rsi,%3
mov rdx,%4
syscall 
%endmacro


section   .text
global _start
_start:
	xor rax,rax
	xor rbx,rbx
	xor rcx,rcx

	scall 02,fname,02,0777

mov qword[fd],rax
bt rax,63
jc next
scall 1,1,msg,len
jmp label
next:
scall 1,1,msg2,len2

	label:
	scall 0,[fd],buffer, 200
	mov qword[buf_len],rax
	mov qword[count1],rax
	mov qword[count2],rax

	bubble:
	mov al,byte[count2]
	mov byte[count1],al
	dec byte[count1]

	mov rsi,buffer
	mov rdi, buffer+1

	loop:
	mov bl,byte[rsi]
	mov cl,byte[rdi]
	cmp bl,cl
	ja swap
	inc rsi
	inc rdi
	dec byte[count1]
	jnz loop
	dec byte[buf_len]
	jnz bubble
	jmp exit

	swap:
	mov byte[rsi],cl
	mov byte[rdi],bl
	inc rsi
	inc rdi
	dec byte[count1]
	jnz loop
	dec byte[buf_len]
	jnz bubble

	
	exit:
	scall 1,1,msg1,len1

	scall 1,1,buffer,qword[count2]

	scall 1,qword[fd],msg1,len1

	scall 1,qword[fd],buffer,qword[count2]

	

	scall 3,fname,0,0
	
	scall 60,0,0,0
