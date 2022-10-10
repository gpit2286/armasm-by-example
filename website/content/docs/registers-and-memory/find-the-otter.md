---
title: "Program 3: Find the Otter"
weight: 3
type: programs

description: >
    Do you like otters? I like otters. 
    Using the below starter code, write 'OTTER' to stdout.
source: https://github.com/gpit2286/armasm-by-example/tree/master/03-find-the-otter
youtube_id: "KrmUX0EKPnE" 
input: https://github.com/gpit2286/armasm-by-example/tree/master/03-find-the-otter/template
output: "OTTER"
---


## ADD operation

You will focus on math heavy concepts later, but for now you do need one operator 
to increment for things like memory addresses and loops. Also, you may have guessed 
that the ADD opcode adds two numbers. Both of these formats are exactly the same. 

```armasm 
    add     r0, r1, r2      @ Add r1 and r2 and store in r0 
    add     r1, r2          @ Add r1 and r2 and store in r1 
```

## STR(-B) operation 

STR is the opposite of LDR. As such, STR takes a value in a register and inserts 
it into memory. Remember that registers are 32-bit values and that STR, by default, 
will write the complete 32-bit value to memory. In the next exercise we only should 
be moving a single byte as opposed to the full 4 bytes. We can do this; both with 
LDR and STR, by appending a -B suffix, we can work on single bytes at a time.[^1]


[^1]: Worth noting, although not used throughout the overall course, that you can 
also use -H for moving a half word worth of data. (2 bytes) 

## Accessing Values in Memory 

When you used a memory address in the "Hello World!" exercise, we took the address 
and provided it to the supervisor (the operating system) and it read the data in 
memory for us and wrote it to STDOUT. If *YOU* want to access the data at an address, 
you need to use the register but with brackets around the register number.[^2] 

```armasm 
    mov         r0, #'A'        @ load the value of A into r0 
    ldr         r1, =outstr     @ load address of outstr into r1 
    strb        r0, [r1]        @ store the first byte in r0 into the address 
                                @ starting at r1 
    strb        r0, r1          @ Does not work  
```

[^2]: I think about it this way. Your friend gives you the address of their house. You 
find the address but you still need to go into the house. You can't just go into 
the address. The brackets are what allow you to go to the house. Eccentric? Yes, but it helps me. 

## Reserving Space, Pt. 1

The last thing you need to know before going into this exercise is how to ask the 
computer to put a little space aside for the program to use. For now, use the data 
section and create a string full of spaces. You can even put the line ending there 
BEFORE writing the program as we already know the length of the output before you 
start. 

```armasm 
.data 
outstr:     .ascii      "     \n" 
```

