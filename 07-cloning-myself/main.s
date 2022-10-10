@ Program 7: Cloning Myself
@ https://www.armasm.com/docs/branches-and-conditionals/cloning-myself/
@
@ Having lived through quarantine, I have decided that I would like the last year 
@ or so of my life back. In order to do this, I am going to clone myself and then 
@ transfer my brain into a new body. However, since replication errors are a thing, 
@ write a program that will show the expected pairs so I can double check.
@ 
@ In DNA strings, symbols “A” and “T” are complements of each other, as “C” and “G”.
@
@   Registers:     
@       r0: input address 
@       r1: tmp byte read 
@       r2: matched letter to write 
.include "write.s" 

.global _start 

_start: 
    ldr     r0, =instr      @ loads the instr address to r0
loop: 
    ldrb    r1, [r0]        @ read byte from input 
    cmp     r1, #0          @ if null, go to ouput 
    beq     exit            
    cmp     r1, #'A'        @ check if we have an A 
    moveq   r2, #'T'        @ load T to write if eq 
    beq     write
    cmp     r1, #'T'        @ check if we have a T 
    moveq   r2, #'A'        @ load A to write if eq 
    beq     write 
    cmp     r1, #'C'        @ check if we have a C
    moveq   r2, #'G'        @ load G to write if eq 
    beq     write           
    mov     r2, #'C'        @ else load C 
write: 
    strb    r2, [r0], #1    @ write and increment address 
    b       loop 
exit: 
    nullwrite   instr       @ write with nullwrite macro 

    ldr     r0, =instr      @ load instr address again 
    mov     r1, #0x000a     @ move newline + \0 to write
                            @ looks backwards because it's little endian 
    strh    r1, [r0]        @ store to memory 
    nullwrite   instr       @ write line ending to stdout 

    mov     r7, #1          @ setup exit call 
    mov     r0, #0          @ 0 = no error 
    svc     0 

.data 
instr:      .ascii      "GTATCGATCGATCGATCGATTATATTTTCGACGAGATTTAAATATATATA"
            .asciz      "TATACGAGAGAATACAGATAGACAGATTA" 
