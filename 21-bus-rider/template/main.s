@ Program 21: Bus Rider
@ https://www.armasm.com/docs/neon/bus-rider/
@
@ Write a program that uses matrix multiplication to solve: 
@   - Bus Trip: $3.00x + $3.20y = $183.80 
@   - Train Trip: $3.50x + $3.60y = $209.90
@
@   Registers: 
@       r4: children total 
@       r5: adult total 
@       d0: matrix containing the price totals 
@       d1: row 1 of inverse matrix 
@       d2: row 2 of inverse matrix 
@       d3: results 
.include "write.s" 

.global _start 

_start: 
    @ Your code here 


.data 
total:      .single     183.8, 209.9 

inv_col1:   .single     -9.0, 8.75 
inv_col2:   .single     8.0, -7.5 

