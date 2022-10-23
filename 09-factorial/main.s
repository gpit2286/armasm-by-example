@ Program 9: Factorials
@ https://www.armasm.com/docs/arithmetic/factorial/
@
@ The two “standard” recursion formulas used in programming are the Fibonacci 
@ series and factorials. Write a program that calculates 9! and prints the 
@ number to stdout.
@
@ Registers 
@   r12 - frame base pointer 

@ Factorial beginning number 
.equ    maxnum, 9 

.global _start 

_start:
    mov     r0, #maxnum     @ load the base number from constant
    mov     r12, sp         @ set stack base to stack pointer 
    push    {r0}            @ add param to stack 
    bl      factorial 

    @ setup itoa 
    mov     r0, r0          @ move total to r0 (noop)     
    ldr     r1, =outstr     @ load outstr address to r1 
    bl      itoa            @ jump to itoa 

    @ write number 
    mov     r7, #4          @ 4 = write 
    mov     r0, #1          @ 1 = stdout 
    mov     r1, r1          @ no op but here for clarity 
    mov     r2, #11         @ 11 = str length 
    svc     0 
    
    @ Clean up stack frame here if nessacary 
    @ setup exit 
    mov     r7, #1          @ 1 = exit 
    mov     r0, #0          @ 0 = no error 
    svc     0 

@   Factorial sub routine 
@ 
@   registers:
@       r0: input number, running total 
@       r1: copy of input for return  
@   returns: 
@       r0: total 
factorial: 
    @ close out caller frame 
    push    {lr}            @ save address to return to 
    push    {r12}           @ save address of base point
    @ move base point to sp to start new frame
    mov     r12, sp         @ set base to stack pointer
    ldr     r0, [r12, #8]   @ load param 0 into r0 
    
    @ if x == 1
    cmp     r0, #1          @ see if we have 1
    beq     fexit           @ set up fac multiply 
    
    @ else x * factorial(x -1)
    push    {r0}            @ save x: [bp - 4]
    sub     r0, #1          @ subtract 1 for next fac call 
    push    {r0}            @ push param: [bp - 8] 
    bl      factorial       @ call factorial 
    ldr     r1, [r12, #-4]  @ recall x and put in r1  
    mul     r0, r1, r0      @ multiply 
    b       fexit           @ go to function cleanup 
fexit:
    mov     sp, r12         @ move sp to frame base
    pop     {r12}           @ restore old base point 
    pop     {lr}            @ restore caller address 
    bx      lr              @ return to caller fn 

.data
outstr:     .fill   11      @ 11 needed for str  
