@ Program 9: Factorials
@ https://www.armasm.com/docs/arithmetic/factorial/
@
@ The two “standard” recursion formulas used in programming are the Fibonacci 
@ series and factorials. Write a program that calculates 9! and prints the 
@ number to stdout.
@
@   Registers:     
@       r0: total 
@       r1: current number 

@ Factorial beginning number 
.equ    maxnum, 9

.global _start 

_start:
    @ Your code here 

.data
outstr:     .fill   11      @ 11 needed for str  
