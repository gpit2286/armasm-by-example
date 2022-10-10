@ Program 20: Here to There
@ https://www.armasm.com/docs/fpu/here-to-there/
@
@ For this exercise, you are given two points. Find the distance between the two 
@ points and then output the parts of the equation.
@
.include "write.s" 

.global _start 

_start: 
    @ Your code here 

.data 
points:     .single         4.0     @ x1
            .single         5.0     @ y1
            .single         2.0     @ x2
            .single         1.0     @ y2


