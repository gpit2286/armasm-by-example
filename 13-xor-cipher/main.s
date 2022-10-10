@ Program 13: XOR Cipher
@ https://www.armasm.com/docs/bit-operations/xor-cipher/
@
@ I need you to login to my account to check some permissions on some files. I've 
@ encrypted the password using an XOR and with the key 214. 
@
@   Registers:     
@       r4: input address  
@       r5: tmp char/value
@
.include "write.s" 

.equ    KEY, 214 

.global _start 

_start: 
    ldr     r4, =instr      @ load instr address 
loop:
    ldrb    r5, [r4]        @ load byte
    cmp     r5, #0          @ comp to null byte
    beq     exit            @ break loop if end 
    eor     r5, r5, #KEY    @ X or byte with key 
    strb    r5, [r4], #1    @ store in same place and increment 
    b       loop 
exit: 
    @ setup write to null macro 
    nullwrite   instr       @ provide instr since we overwrote 
                            @ the same as output 
    
    @ put line ending 
    mov     r5, #0x000a     @ move line ending and null into r5 
    ldr     r4, =instr      @ move back to beginning of instr 
    strh    r5, [r4]        @ store to memory 
    nullwrite   instr       @ write line ending 

    @ setup exit 
    mov     r7, #1          @ 1 = exit 
    mov     r0, #0          @ 0 = no error 
    svc     0

.data 
instr:      .byte       0xbe, 0xa3, 0xb8, 0xa2, 0xb3, 0xa4, 0xe4, 0x00
