@ Program 14: Hex and Love
@ https://www.armasm.com/docs/bit-operations/hex-and-love/
@
@ I have a bunch of colors saved from my web programing and I would like to 
@ take those rgb values and convert them to #rrggbb values. Write a program 
@ that takes sets of three rgb values and converts them into the #rrggbb hex 
@ representation.
@ 
@ Note: The red color will never be 0.
.global _start 

_start: 

    @ Your code here!!! 


.data 
input:      .byte       212, 228, 188
            .byte       150, 172, 183
            .byte       54, 85, 143
            .byte       64, 55, 110
            .byte       72, 35, 60
            .byte       0   
