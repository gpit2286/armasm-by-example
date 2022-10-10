@ Program 5:  Hello World Revisited
@ https://www.armasm.com/docs/branches-and-conditionals/hello-world-revisited/
@
@ Write a program displays "Hello World!" and exits with the error code 0. 
@ For the writing of the string, use a macro that prints using a null 
@ terminated string.

.include "write.s" 

.global _start

_start:
    @ Write hello world 
    nullwrite   hello
    
    @ setup exit syscall 
    mov     r7, #1      @ 1 = exit 
    mov     r0, #0      @ 0 = no error 
    svc     0

.data 
hello:      .asciz      "Hello World!\n"
