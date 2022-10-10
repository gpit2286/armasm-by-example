@ Program 7: Cloning Myself
@ https://www.armasm.com/docs/branches-and-conditionals/cloning-myself/
@
@ Having lived through quarantine, I have decided that I would like the last year 
@ or so of my life back. In order to do this, I am going to clone myself and then 
@ transfer my brain into a new body. However, since replication errors are a thing, 
@ write a program that will show the expected pairs so I can double check.
@ 
@ In DNA strings, symbols “A” and “T” are complements of each other, as “C” and “G”.
@

.include "write.s" 

.global _start 

_start: 
 


.data 
instr:      .ascii      "GTATCGATCGATCGATCGATTATATTTTCGACGAGATTTAAATATATATA"
            .asciz      "TATACGAGAGAATACAGATAGACAGATTA" 
