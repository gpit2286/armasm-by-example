@ Program 19: Add the File
@ https://www.armasm.com/docs/working-in-linux/add-the-file/
@
@ There is a file named numbers in the template directory. Open this file with 
@ your program and then read it line by line, creating a grand total of all the 
@ numbers. After adding all the numbers, display the sum.
@
@   Registers: 
@       r4: running total     
@       r5: fd for file 
@       r6: read buffer 
@       r7: reserved for svc 
@       r8: output buffer  
@       r9: tmp space 
@       r10: last number bool flag 

.equ    O_RDONLY, 0x0 

.include "write.s"

.global _start 

_start:
    mov     r4, #0          @ init total
    ldr     r8, =outbuf     @ init out buffer 
    mov     r10, #0         @ init last number 

    @ setup open 
    mov     r7, #5          @ 5 = open 
    ldr     r0, =fname      @ fname = file to open 
    mov     r1, #O_RDONLY   @ mode = readonly 
    mov     r2, #0          @ no needed for read only 
    svc     0 

    mov     r5, r0          @ move fd to store for use later 
    
readchunk:
    @ read chunk of file 
    mov     r7, #3          @ 3 = read 
    mov     r0, r5          @ r5 = fd of open file 
    ldr     r1, =readbuf    @ read buffer 
    mov     r2, #63         @ 64 = length - 1 to get null term 
    svc     0 

    cmp     r0, #0          @ if zero, we hit EOF. (zero bytes read) 
    beq     gotoexit        @ goto exit determines if we need to process 
                            @ an outstanding number or not. This is only 
                            @ really a case for EOF with no \n
    ldr     r6, =readbuf    @ reset read buffer addr 
    mov     r1, #0          @ load null byte 
    strb    r1, [r6, r0]    @ set a null byte explictly. This is because 
                            @ we keep reusing the same memory space and 
                            @ if we don't have 63 chars read, we need this 
                            @ byte to mark EOF
readnum:
    ldrb    r9, [r6], #1    @ read byte and increment 
    cmp     r9, #'\n'       @ if line ending, go to next part 
    beq     procnum 
    cmp     r9, #0          @ end of buffer - continue reading no problem  
    beq     readchunk       @ try reading more from file 
    strb    r9, [r8], #1    @ if neither, store byte in out and go to next 
    b       readnum
procnum: 
    mov     r0, #0          @ setup null for outstr 
    strb    r0, [r8]        @ store null char to prepare for atoi 

    @ setup atoi 
    ldr     r0, =outbuf     @ set buffer address to r0 
    bl      atoi 
    add     r4, r4, r0      @ add the returned number to total 
    
    cmp     r10, #1         @ check to see if last flag is set 
    beq     exit            @ If set, leave to display number 

    ldr     r8, =outbuf     @ reset out buffer address 
    mov     r9, #0          @ noop, here for clarity 
    strb    r9, [r8]        @ set null char as first char in output 
    b       readnum
gotoexit: 
    ldr     r0, =outbuf     @ if this is zero, we should be done 
    ldrb    r0, [r0]        @ load actual value 
    cmp     r0, #0          
    beq     exit
    mov     r10, #1         @ set last time flag 
    b       procnum         @ if there is something there, go to process
exit: 
    @ setup itoa
    mov     r0, r4          @ move total to r4
    ldr     r1, =outbuf     @ move buffer to r1 for write
    @ zero out output 
    mov     r2, #0          @ store null byte to use 
    str     r2, [r1]        @ bytes 0-3 
    str     r2, [r1, #4]    @ bytes 4-7 
    str     r2, [r1, #8]    @ bytes 8-11  
    bl      itoa            
    
    @ setup nullwrite 
    nullwrite   outbuf 

    @ setup exit 
    mov     r7, #1          @ 1 = exit 
    mov     r0, #0          @ 0 = no error 
    svc     0 

.data
fname:      .asciz      "numbers"
outbuf:     .fill       12      @ 12 = 10 digits + \n + \0  
readbuf:    .fill       64      @ read buffer 64 bytes 
