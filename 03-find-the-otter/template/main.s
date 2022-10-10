@ Program 3:  Find the Otter 
@ https://www.armasm.com/docs/registers-and-memory/find-the-otter/
@
@ Reads pre-loaded values in the registers and writes 
@ OTTER to STDOUT 

.global _start 

_start: 
    @@@@@@@@@@@@@@@@ Begin Register Preload 
    mov     r0, #'P' 
    mov     r1, #'O'
    mov     r2, #'I'
    mov     r3, #'U'
    mov     r4, #'Y'
    mov     r5, #'T'
    mov     r6, #'R'
    mov     r7, #'E'
    mov     r8, #'W'
    mov     r9, #'Q'
    @@@@@@@@@@@@@@@@ End Register Preload 

    @ Write your program here!!! 