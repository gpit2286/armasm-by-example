@ Program 18: Add the Inputs
@ https://www.armasm.com/docs/working-in-linux/add-the-inputs/
@
@ For this program, create a program that prompts the user to enter some numbers. 
@ After each number, total the numbers entered by the user. When an empty line is 
@ entered, display the total.
.include "write.s"

.global _start 

_start:
    @ Your code here! 


.data
prompt:     .asciz      "Input a number to add or Enter to sum:\n"
