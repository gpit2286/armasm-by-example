@ Program 18: Add the Inputs
@ https://www.armasm.com/docs/working-in-linux/add-the-inputs/
@
@ For this program, create a program that prompts the user to enter some numbers. 
@ After each number, total the numbers entered by the user. When an empty line is 
@ entered, display the total.
@
@   Registers: 
@       r4: running total     
.include "write.s"

.global _start 

_start:
    mov     r4, #0          @ init total
loop:
    @ setup prompt 
    nullwrite   prompt

    @ setup input 
    mov     r7, #3          @ 3 = read 
    mov     r0, #0          @ 0 = stdin 
    ldr     r1, =buf        @ load buffer address 
    mov     r2, #10         @ 10 max input length 
    svc     0 

    @ setup atoi 
    ldr     r0, =buf        @ set buffer address to r0 
    ldrb    r5, [r0]        @ check first char 
    cmp     r5, #'\n'       @ if we only received a \n, then there was no 
                            @ more numbers inputted 
    beq     exit
    
    bl      atoi 
    add     r4, r4, r0      @ add the returned number to total 
    
    b       loop
exit: 
    @ setup itoa
    mov     r0, r4          @ move total to r4
    ldr     r1, =buf        @ move buffer to r1 for write 
    bl      itoa            
    
    @ setup nullwrite 
    nullwrite   buf 

    @ setup exit 
    mov     r7, #1          @ 1 = exit 
    mov     r0, #0          @ 0 = no error 
    svc     0 

.data
prompt:     .asciz      "Input a number to add or Enter to sum:\n"
buf:        .fill       12      @ 12 = 10 digits + \n + \0  

