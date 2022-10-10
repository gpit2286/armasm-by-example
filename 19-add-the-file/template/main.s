@ Program 19: Add the File
@ https://www.armasm.com/docs/working-in-linux/add-the-file/
@
@ There is a file named numbers in the template directory. Open this file with 
@ your program and then read it line by line, creating a grand total of all the 
@ numbers. After adding all the numbers, display the sum.
@
.equ    O_RDONLY, 0x0 

.include "write.s"

.global _start 

_start:
    @ Your code here 