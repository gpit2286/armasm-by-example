@ Program 6: Sticky Keyboard
@ https://www.armasm.com/docs/branches-and-conditionals/sticky-keyboard/
@
@ My keyboard sucks. Thanks Apple. The keys stick badly. (They don't really)
@ Write a program that takes a string and removes the duplicate letters. 
@
@   Registers:     
@       r0: input address 
@       r1: output address 
@       r2: tmp byte read 
@       r3: last byte read 

.include "write.s" 

.global _start 

_start: 
    ldr     r0, =instr      @ load instr address 
    ldr     r1, =outstr     @ load outstr address 
    mov     r3, #0          @ set last read to null for comparison  

loop:
    ldrb    r2, [r0], #1    @ load char and increment 
    cmp     r2, #0          @ see if we are at end of string 
    beq     exit            @ leave loop 
    cmp     r2, r3          @ compare read char to last char 
    beq     loop            @ if the same, go to next char 
    strb    r2, [r1], #1    @ store byte and increment 
    mov     r3, r2          @ move char to "last byte read"
    b       loop
exit: 
    nullwrite       outstr  @ write to std out 

    mov     r7, #1          @ Setup exit syscall 
    mov     r0, #0          @ 0 = no error 
    svc     0

.data 
instr:      .ascii      "I jjjjust   waaaaant thhhis stuppppid " 
            .asciz      "tttthinggggg tooooo wwwwworrrrrrrk!!!!!!!\n"
outstr:     .fill       128, 1, 0    @ Reserve 128 bytes
