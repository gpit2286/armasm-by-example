@ Program 16: 64-bit Math
@ https://www.armasm.com/docs/bit-operations/64-bit-math/
@
@ Multiply two 32-bit numbers. Take the result and write an integer to ASCII 
@ program that reads 64 bit numbers using this shift/long division method.


.global _start 

_start: 
    ldr     r0, =0xbf85be21     @ pseudo instruction load 1
    ldr     r1, =0xce0a6a80     @ pseudo instruction load 2

    @ Your code here! 
     
.data
output:     .fill       21      @ max 64-bit unsigned is 20 digits long + 1 for \n



