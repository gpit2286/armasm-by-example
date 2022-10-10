@ Program 11: All Positivity
@ https://www.armasm.com/docs/bit-operations/positivty/
@
@ I created a program to rate all of my friends based on their “positivity index.” 
@ To protect the innocent, I have removed their names.  Take the list of 
@ positivity scores and determine if I have more or less positive friends than 
@ negative friends. Output “POS” or “NEG” depending on the result. There are no 
@ scores as the score list is terminated with zero.
@ 
@   Registers:     
@       r4: numlist 
@       r5: pos count 
@       r6: neg count
@       r7: tmp byte 
@
.global _start 

_start: 
    ldr     r4, =numlist        @ load the number list 
    mov     r5, #0              @ init pos count 
    mov     r6, #0              @ init neg count 
loop:
    ldrsb   r7, [r4], #1        @ load number and increment 
    cmp     r7, #0              @ see if end of numbers 
    beq     exit                @ if eq, zero is set and it's the end 
    addmi   r6, #1              @ add one if negative 
    addpl   r5, #1              @ add one if positive 
    b       loop 
exit: 
    cmp     r5, r6              @ compare number counts 
    ldrgt   r1, =posstr         @ preload pos str if more positives 
    ldrle   r1, =negstr         @ preload neg str if other 
    
    @ setup write 
    mov     r7, #4              @ 4 = write 
    mov     r0, #1              @ 1 = stdout 
                                @ r1 loaded above 
    mov     r2, #4              @ 4 = len 
    svc     0 

    @ setup exit 
    mov     r7, #1              @ 1 = exit 
    mov     r0, #0              @ 0 = no error 
    svc     0

.data 
posstr:     .ascii  "POS\n" 
negstr:     .ascii  "NEG\n" 
numlist:    .byte   -84, -20, 84, -29, 21, 98, 54, 33, -86, -64
            .byte   -14, 38, -85, -86, -88, 72, 23, -42, -1, -85
            .byte   -64, -80, 24, -86, -73, 38, 8, 96, -93, 75
            .byte   -18, -7, -30, -75, -42, 30, 70, -98, 34, -34
            .byte   -46, 35, -10, 73, 31, 11, -33, 77, -24, 40, 0 
