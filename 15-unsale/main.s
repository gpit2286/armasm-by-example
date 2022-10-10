@ Program 15: The Un-sale
@ https://www.armasm.com/docs/bit-operations/unsale/
@
@ The shop I own (I don’t) had a sale but some employee decided to not write 
@ down the original price of all of the items! Well, it’s simple because all of 
@ the prices are 1/3 of their original amounts. The problem is I have a billion 
@ prices so I need to figure out how to get the original price as quickly as 
@ possible!!! Take the list of prices and output the original price. No need to 
@ output the discounted price. This will be used a called function in bigger program.
@
@   Registers:     
@       r4: current number 
@       r5: result 
@       r6: number array 
@
.global _start 

_start: 
    ldr     r6, =input          @ load input address
loop:
    ldr     r4, [r6], #4        @ load first number and increment
    cmp     r4, #0              @ see if we hit end of list
    beq     exit                @ jump to exit if zero 
    rsb     r5, r4, r4, lsl #2  @ perform (r4*4) - r4 and store in r5 
    
    @ setup itoa 
    mov     r0, r5              @ Move total to r0 
    ldr     r1, =output         @ load output str 
    bl      itoa                

    @ setup write 
    mov     r7, #4          @ 4 = write 
    mov     r0, #1          @ 1 = stdout 
    mov     r1, r1          @ noop, only for clarity 
    mov     r2, #11         @ 11 = max string length 
    svc     0 

    @ erase memory in output 
    mov     r0, #0          @ load 0 for erase
    str     r0, [r1]        @ erase first 4 bytes
    str     r0, [r1, #4]    @ erase second 4 bytes
    str     r0, [r1, #8]    @ erase last four bytes
    
    b       loop 
exit: 
    @ setup exit 
    mov     r7, #1          @ 1 = exit 
    mov     r0, #0          @ 0 = no error 
    svc     0

.data 
input:      .word   911, 869, 566, 958, 787, 0
output:     .fill   12
