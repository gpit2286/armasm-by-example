@ Program 13: XOR Cipher
@ https://www.armasm.com/docs/bit-operations/xor-cipher/
@
@ I need you to login to my account to check some permissions on some files. I've 
@ encrypted the password using an XOR and with the key 214. 
.include "write.s" 

.equ    KEY, 214 

.global _start 

_start: 
   @ Your code here 

.data 
instr:      .byte       0xbe, 0xa3, 0xb8, 0xa2, 0xb3, 0xa4, 0xe4, 0x00
