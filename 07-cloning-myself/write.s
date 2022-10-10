@@@@@@
@   Outputs a null terminated string to stdout
@
@   r0  -   output str address
@   r1  -   search address
@   r2  -   tmp search bit 
@   r3  -   str length 
@
@   labels: 
@       1: Length loop 
@       2: Output syscall 
@@@@@@

.macro      nullwrite       outstr
    @ Find length of string 
    ldr     r0, =\outstr        @ load outstring address
    mov     r1, r0              @ copy address for len calc later 
1:
    ldrb    r2, [r1]            @ load first char 
    cmp     r2, #0              @ check to see if we have a null char 
    beq     2f  
    add     r1, #1              @ Increment search address 
    b       1b                  @ go back to beginning of loop     
2:
    sub     r3, r1, r0          @ calculate string length 
    
    @ Setup write syscall 
    mov     r7, #4              @ 4 = write 
    mov     r0, #1              @ 1 = stdout 
    ldr     r1, =\outstr        @ outstr address 
    mov     r2, r3              @ load length 
    svc     0 
.endm 




