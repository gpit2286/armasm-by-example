@ Program 10: Sum of Squares
@ https://www.armasm.com/docs/arithmetic/sum-of-squares/
@
@ You are given a list of numbers. Iterate through the numbers, squaring them, 
@ and then creating a sum of the squared numbers.
@ 
@ For example.
@ 
@ Input: 5, 7, 2 => 25, 49, 4 => 78
@ 
@
@   Registers:     
@       r4: input byte address  
@       r5: tmp mul number to square  
@       r6: total 
.global _start 

_start: 
    ldr     r4, =inarr      @ load beginning of byte array address 
    mov     r6, #0          @ init total 
loop: 
    ldrb    r5, [r4], #1    @ read next integer and increment addr 
    cmp     r5, #0          @ see if we are at the end of the list 
    beq     exit 
    mla     r6, r5, r5, r6  @ r6 = (r5 * r5) + r6 
    b       loop            @ go again 
exit: 
    @ setup itoa call
    mov     r0, r6          @ set total to convert 
    ldr     r1, =outstr     @ set output address 
    bl      itoa 

    @ setup write 
    mov     r7, #4          @ 4 = write 
    mov     r0, #1          @ 1 = stdout 
    mov     r1, r1          @ noop, only for clarity 
    mov     r2, #11         @ 11 = max string length 
    svc     0 

    @ setup exit 
    mov     r7, #1          @ 1 = exit 
    mov     r0, #0          @ 0 = no error 
    svc     0

.data
inarr:      .byte   65,71,71,71,67,72,66,51,58,50
            .byte   60,60,55,64,52,69,52,67,55,69,0
outstr:     .fill   11
