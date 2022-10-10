@ Program 4:  Memory Copy
@ https://www.armasm.com/docs/registers-and-memory/memory-copy/
@
@ Reads data from one point in data, copies it, and then 
@ outputs the result 

.global _start 

_start:
    ldr     r0, =instr          @ load instr address 
    ldr     r1, =outstr         @ load outstr address 

    ldrb    r3, [r0]            @ load S to r3 
    strb    r3, [r1]            @ store value in r3 to outstr 
    add     r0, #1              @ increment instr 
    add     r1, #1              @ increment outstr 
 
    ldrb    r3, [r0]            @ load U to r3 
    strb    r3, [r1]            @ store value in r3 to outstr 
    add     r0, #1              @ increment instr 
    add     r1, #1              @ increment outstr 

    ldrb    r3, [r0]            @ load M to r3 
    strb    r3, [r1]            @ store value in r3 to outstr 
    add     r0, #1              @ increment instr 
    add     r1, #1              @ increment outstr 

    ldrb    r3, [r0]            @ load M to r3 
    strb    r3, [r1]            @ store value in r3 to outstr 
    add     r0, #1              @ increment instr 
    add     r1, #1              @ increment outstr 

    ldrb    r3, [r0]            @ load E to r3 
    strb    r3, [r1]            @ store value in r3 to outstr 
    add     r0, #1              @ increment instr 
    add     r1, #1              @ increment outstr 

    ldrb    r3, [r0]            @ load R to r3 
    strb    r3, [r1]            @ store value in r3 to outstr 
    add     r0, #1              @ increment instr 
    add     r1, #1              @ increment outstr 

    mov     r3, #'\n'           @ load line ending for outstr 
    strb    r3, [r1]            @ store line ending 

    @ setup write to stdout 
    mov  r7, #4          @ Setup service call 4 (write)
    mov  r0, #1          @ param 1 - File descriptor 1 = stdout
    ldr  r1, =outstr     @ param 2 - address of string to print
    mov  r2, #7          @ param 3 - length of output (SUMMER + \n)
    svc  0               @ ask linux to write to stdout

    mov  r7, #1          @ Setup service call 1 (exit)
    mov  r0, #0          @ param 1 - 0 = normal exit
    svc  0               @ ask linux to terminate us

.data
instr:      .ascii      "SUMMER"
outstr:     .fill       7, 1, 0
