@ Program 4:  Memory Copy
@ https://www.armasm.com/docs/registers-and-memory/memory-copy/
@
@ Reads data from one point in data, copies it, and then 
@ outputs the result 

.global _start 

_start:
    @@ Your code here. 



.data
instr:      .ascii      "SUMMER"
outstr:     .fill       7, 1, 0