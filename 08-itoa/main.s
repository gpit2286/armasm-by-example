@ Program 8: ITOA
@ https://www.armasm.com/docs/arithmetic/itoa/
@
@ If you are going to print numbers to stdout, you need to come up with a way 
@ to convert those numbers into an ASCII representation. For now, just worry 
@ about unsigned numbers.
@ 
@ Write a program that loads the number 209867295 and writes it to stdout.
@
@   Registers:     
@       r4: output address  
@       r5: number to process 
@       r6: current 10^x
@       r7: current power (x from above) 
@       r8: loop counter

@ input number 
.equ    basenum, 209867295

@   pow macro 
@   
@   r0:     base 
@   r1:     exp 
@   r2:     total 
@
@ labels
@   1: main loop 
@   2: exit macro 
@ 
@ output 
@   r0: result 
.macro      pow     base, exp 
    mov     r0, \base   @ load base 
    mov     r1, \exp    @ load expo
    cmp     r1, #0      @ see if expo is zero 
    moveq   r2, #1      @ if yes, total will be 1 
    beq     2f
    mov     r2, r0      @ copy base to total
    sub     r1, #1      @ sub one off expo because we copied base 
1: 
    cmp     r1, #0      @ test if we need to multiply again 
    ble     2f          @ leave if eq or less than 0 
    mul     r2, r0 ,r2  @ multiply total by base and store in total 
    sub     r1, #1      @ decrement expo 
    b       1b 
2:
    mov     r0, r2      @ move result to r0
.endm 

.global _start 

_start: 
    ldr     r4, =outstr     @ load outstr address
    ldr     r5, =basenum    @ load number to process
                            @ because it's larger than an immediate, we 
                            @ use the pseudo instruction like this 
    mov     r7, #9          @ Initial power of 10 
    mov     r8, #0          @ init loop counter 

    @ find first power of ten to use
findstart:
    pow     #10, r7         @ get cur power of ten 
    mov     r6, r0          @ move pow result to r6 
    cmp     r6, r5          @ compare 10^x to number to print 
    ble     finddigit       @ if less than number, go to printing 
    sub     r7, #1          @ if still bigger than num to print, 
                            @ decrement pow and try again 
    b       findstart   
    @ process number and print 
finddigit:
    cmp     r5, r6          @ compare remaining number to 10^x 
    blt     write           @ if less than, write digit 
    add     r8, r8, #1      @ increment counter 
    sub     r5, r5, r6      @ subtract 10^x from remaining and go again 
    b       finddigit 
write:
    add     r8, #'0'        @ add counter to ASCII zero to get number 
    strb    r8, [r4], #1    @ store in outstr and increment 

    @ prepare next loop 
    sub     r7, #1          @ subtract one from the counter
    cmp     r7, #0          @ compare expo to 0 
    blt     exit            @ if expo is <zero, leave loop 
    pow     #10, r7         @ get next power of ten 
    mov     r6, r0          @ move 10^x into r6 
    mov     r8, #0          @ reset loop counter 
    b       finddigit 
exit: 
    mov     r8, #'\n'       @ load line ending for output str 
    strb    r8, [r4]        @ store to output. no need to increment  

    @ setup write call 
    mov     r7, #4          @ 4 = write
    mov     r0, #1          @ 1 = stdout 
    ldr     r1, =outstr     @ load outstr address 
    mov     r2, #11         @ 11 = max length 
    svc     0 

    @ setup exit call 
    mov     r7, #1          @ 1 = exit 
    mov     r0, #0          @ 0 = no error 
    svc     0

.data
outstr:     .fill 11        @ the max output size is 10 digits 
                            @ 11 for line ending 
