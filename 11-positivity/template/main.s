@ Program 11: All Positivity
@ https://www.armasm.com/docs/bit-operations/positivty/
@
@ I created a program to rate all of my friends based on their “positivity index.” 
@ To protect the innocent, I have removed their names. Take the list of 
@ positivity scores and determine if I have more or less positive friends than 
@ negative friends. Output “POS” or “NEG” depending on the result. There are no 
@ scores as the score list is terminated with zero.
@ 

.global _start 

_start: 
   @ Your code here 


.data 
numlist:    .byte   -84, -20, 84, -29, 21, 98, 54, 33, -86, -64
            .byte   -14, 38, -85, -86, -88, 72, 23, -42, -1, -85
            .byte   -64, -80, 24, -86, -73, 38, 8, 96, -93, 75
            .byte   -18, -7, -30, -75, -42, 30, 70, -98, 34, -34
            .byte   -46, 35, -10, 73, 31, 11, -33, 77, -24, 40, 0 
