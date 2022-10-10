@ Program 8: ITOA
@ https://www.armasm.com/docs/arithmetic/itoa/
@
@ If you are going to print numbers to stdout, you need to come up with a way 
@ to convert those numbers into an ASCII representation. For now, just worry 
@ about unsigned numbers.
@ 
@ Write a program that loads the number 209867295 and writes it to stdout.


@ input number 
.equ    basenum, 209867295

.global _start 

_start: 

@ Your Code here!! 

.data
outstr:     .fill 11        @ the max output size is 10 digits 
                            @ 11 for line ending 
