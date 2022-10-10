@ Program 17: Add the Arguments
@ https://www.armasm.com/docs/working-in-linux/add-the-arguments/
@
@ The next couple of exercises are all going to be doing the same thing. 
@ Reading inputs, adding them together, and then outputting the result. 
@ For this, you will first need to create an ASCII to integer function. 
@ (Unsigned integer is fine) Create this in an outside file so you can reuse it.
@
@ Registers
@   r4: total 
.global _start

_start: 
    mov     r4, #0          @ init total 
    add     sp, #8          @ Add 8 to SP to get to first arg address 
loop: 
    @ setup atoi 
    pop     {r0}            @ load address into r0 from stack 
    cmp     r0, #0          @ see if we have end of list 
    beq     exit
    bl      atoi            @ call atoi 
    add     r4, r4, r0      @ add result to r0 
    b       loop 
exit: 
    @ setup itoa 
    mov     r0, r4          @ load total to r0 
    ldr     r1, =output     @ load output address to r1 
    bl      itoa            @ call itoa 

    @ write output 
    mov     r7, #4          @ 4 = write 
    mov     r0, #1          @ 1 = stdout 
    ldr     r1, =output     @ load output address 
    mov     r2, #11         @ 11 = length 
    svc     0 

    @ setup exit 
    mov     r7, #1          @ 1 = exit 
    mov     r0, #0          @ 0 = no error
    svc     0

.data
output:     .fill       11 

