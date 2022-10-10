---
title: Datatypes
weight: 2
---

# Datatypes 

## The string types 

The first set of built in data types are the two that you have already learned: ascii and 
asciz. To review, both ascii and asciz encode ASCII characters to their integer 
equivalents. The asciz directive adds a null character to the end of the string. 

## The integer types 

In the data section you can also specify integers that will be loaded with the program. 
In addition, you can also specify the amount of space that the integer consumes. 
The possible types are: 

- .byte: 1 byte 
- .short: 2 bytes
- .word: 4 bytes
- .quad: 8 bytes 
- .octa: 16 bytes 

### Example of assignments 

```armasm 
.data
label1:     .byte       0x44, 0x22, 0x11    @ Loads 
                                            @ addr+0: 0x44
                                            @ addr+1: 0x22
                                            @ addr+2: 0x11
label2:     .short      0x44, 0x22, 0x11    @ Loads
                                            @ addr+0: 0x0044
                                            @ addr+2: 0x0022
                                            @ addr+4: 0x0011 
label3:     .word       0x44, 0x22, 0x11    @ Loads 
                                            @ addr+0: 0x00000044
                                            @ addr+4: 0x00000022
                                            @ addr+8: 0x00000011
```
