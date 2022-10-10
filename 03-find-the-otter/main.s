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

    ldr     r10, =outstr        @ load output string address 
    strb    r1, [r10]           @ put 'O' into output 
    add     r10, #1             @ increment output address 
    strb    r5, [r10]           @ put 'T' into output 
    add     r10, #1             @ increment output address
    strb    r5, [r10]           @ put second 'T' into output 
    add     r10, #1             @ increment output address 
    strb    r7, [r10]           @ put 'E' into output 
    add     r10, #1             @ increment output address 
    strb    r6, [r10]           @ put 'R' into output 

    @ setup write to stdout 
    mov  r7, #4          @ Setup service call 4 (write)
    mov  r0, #1          @ param 1 - File descriptor 1 = stdout
    ldr  r1, =outstr     @ param 2 - address of string to print
    mov  r2, #6          @ param 3 - length of output (OTTER + \n)
    svc  0               @ ask linux to write to stdout

    mov  r7, #1          @ Setup service call 1 (exit)
    mov  r0, #0          @ param 1 - 0 = normal exit
    svc  0               @ ask linux to terminate us

.data
outstr:     .ascii      "     \n" 
