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

.global _start 

_start: 
    @ Your code here 


.data
inarr:      .byte   65,71,71,71,67,72,66,51,58,50
            .byte   60,60,55,64,52,69,52,67,55,69,0
outstr:     .fill   11
