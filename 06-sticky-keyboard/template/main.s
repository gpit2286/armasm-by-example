@ Program 6:  Hello World Revisited
@ https://www.armasm.com/docs/branches-and-conditionals/sticky-keyboard/
@
@ My keyboard sucks. Thanks Apple. The keys stick badly. (They don't really)
@ Write a program that takes a string and removes the duplicate letters. 
@
@

.include "write.s" 

.global _start 

_start: 
   @ Your code here 

.data 
instr:      .ascii      "I jjjjust   waaaaant thhhis stuppppid " 
            .asciz      "tttthinggggg tooooo wwwwworrrrrrrk!!!!!!!\n"
outstr:     .fill       128, 1, 0     @ Reserve 128 bytes
