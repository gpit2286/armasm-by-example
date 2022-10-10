@ Program 16: 64-bit Math
@ https://www.armasm.com/docs/bit-operations/64-bit-math/
@
@ Multiply two 32-bit numbers. Take the result and write an integer to ASCII 
@ program that reads 64 bit numbers using this shift/long division method.
@
@   Registers:     
@       r4: 64-low 
@       r5: 64-high  
@       r6: working number 
@       r7: number to write 
@       r8: output memory 
@       r9: inner loop counter (bit subtraction)      

.global _start 

_start: 
    ldr     r0, =0xbf85be21     @ pseudo instruction load 1
    ldr     r1, =0xce0a6a80     @ pseudo instruction load 2
    umull   r4, r5, r0, r1      @ r0 * r1 = high: r5, low: r4
    
    ldr     r8, =output         @ load output memory 
                                @ you need to build this backwards. so we will 
    add     r8, #20             @ take the address and add the length -1 as 
                                @ it's zero indexed 
    mov     r7, #'\n'           @ load line ending 
    strb    r7, [r8], #-1       @ store line ending and decrement 
 
    mov     r10, #0             @ init outer counter 
outer: 
    add     r10, #1             @ add one to outer counter 
    cmp     r10, #20            @ compare to max length 
    bgt     write               @ if we reached max, write the number 
    mov     r9, #0              @ init loop counter 
    mov     r6, #0              @ init working number 
loop:
    add     r9, #1              @ add one to counter 
    cmp     r9, #64             @ compare to max bits 
    bgt     store               @ store number if we get to end 
    lsl     r6, #1              @ shift working number 
    lsls    r5, #1              @ shift top half of number 
    adc     r6, #0              @ add 0 + carry to working number 
    lsls    r4, #1              @ shift bottom half of number 
    adc     r5, #0              @ add 0 + carry to top half 
    cmp     r6, #10             @ this will always be two ops. either subs and 
                                @ store result and mov or cmp and sub. 
    blt     loop                @ if working < 10, go to next loop 
    sub     r6, r6, #10         @ subtract 10 
    add     r4, #1              @ add 1 to bottom to set up for next loop 
    b       loop 
store: 
    add      r7, r6, #'0'       @ get ASCII by adding remainder to char 0 
    strb     r7, [r8], #-1      @ store and increment output address 
    b        outer              @ go back to outer loop 
write: 
   @ setup write 
    mov     r7, #4              @ 4 = write 
    mov     r0, #1              @ 1 = stdout 
    ldr     r1, =output         @ load output address 
    mov     r2, #21             @ max length of string 
    svc     0 

    @ setup exit 
    mov     r7, #1              @ 1 = exit 
    mov     r0, #0              @ 0 = no error 
    svc     0

.data
output:     .fill       21      @ max 64-bit unsigned is 20 digits long + 1 for \n



