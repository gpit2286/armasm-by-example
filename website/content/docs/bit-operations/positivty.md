---
title: "Program 11: All Positivity"
weight: 2
type: programs

description: >
    I created a program to rate all of my friends based on their "positivity index." 
    To protect the innocent, I have removed their names. 🤣 Take the list of positivity 
    scores and determine if I have more or less positive friends than negative friends. 
    Output "POS" or "NEG" depending on the result. There are no 0 scores and the score 
    list is terminated with zero. 

source: https://github.com/gpit2286/armasm-by-example/tree/master/11-positivity
youtube_id: "VV1b2ka00aU" 
input: https://github.com/gpit2286/armasm-by-example/tree/master/11-positivity/template
output: "NEG"
---


 
## Revisiting the N flag 

You learned briefly that the N flag is set if the number, interpreted as signed,  
used to set the CPSR is a negative number. You may be surprised to know, that 
really this flag is a mirror of the most significant bit. No, seriously. It's that 
simple. Imagine the ARM processor had 8-bit registers as opposed to 32-bit. 

|  Number | 8-bit register | N set? | 
|:-------:|:---------------------|:------:|
| 22      | 0b<u>0</u>0010110           | N      |
| -22     | 0b<u>1</u>1101010           | Y      |
| 200     | 0b<u>1</u>1101010           | Y      | 

The number 200 again illustrates that the processor itself inherently does not 
know if it is working with positive or negative numbers, and it's a construct 
the user determines. 

## LDRSB/STRSB/LDRSH/STRSH operations 

Unfortunately(?), the processor DOES have 32-bit registers. This means that if you 
are working with numbers that are less than 32-bits, you need to be aware or you 
could make some negative numbers positive very quickly. 

Imagine you have these two numbers stored in single bytes: 6, -7 

If you used the STRB operation to move 6 from memory to a register, there won't 
be a problem. 

```text
memory:                            00000000  6
ldrb:
result: 00000000 00000000 00000000 00000110  6
```

But if you tried doing this with -7, you all of a sudden get a positive number. 

```text 
memory:                            11111001 -7
ldrb 
result: 00000000 00000000 00000000 11111001 249
```

To accommodate for this, the architects implemented signed load and store 
instructions for byte and half word operations. [^1] Essentially it just takes the 
bit in the most significant position of the loaded data and fills that to the rest 
of the data space. 

```text
memory:                            11111001 -7
lrdsb 
result: 11111111 11111111 11111111 11111001 -7
```

[^1]: No need to do this for word operations because the load/str will never 
add empty bytes to the register. 
