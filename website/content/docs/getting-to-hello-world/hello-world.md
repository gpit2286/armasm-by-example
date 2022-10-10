---
title: "Program 2: Hello World"
weight: 3
type: programs

description: >
    Write a program that prints "Hello World!". 
source: https://github.com/gpit2286/armasm-by-example/tree/master/02-hello-world
youtube_id: "ZWjlZ5ErUw4" 
input: https://github.com/gpit2286/armasm-by-example/tree/master/02-hello-world/template
output: "Hello World!"
---


From the exiting program, you can add a couple more lines before it to actually 
output the "Hello World!" 

## Labels 

You have already used the `_start:` label but what does that *actually* do? A label 
simply names a place in the program that you can reference to later. In the data 
section, it's common to label the beginning part of a piece of data. When this 
happens, that label and all references to it, will become the same address that 
points to a place in the data loaded into memory.  

## The data section 

In the data section, the format is: 

```
label:?     .datatype       data 
```

In this example you are going to use the ascii datatype which takes the data 
between the two double quotes and converts them to their ASCII equivalence. You 
will see other types of data in the near future. 

## LDR operation 

Like the `mov` opcode, `ldr` **loads** a value into a register. However, unlike 
`mov`, `ldr` loads a value from memory. This is a small but very important 
difference. But in order to load a value from memory, you need to know where in 
memory it is located. Luckily for us, the compiler will do the calculation for 
use if you reference a label in the data section. 

```armasm
    ldr     r1, =hello          @ Load the address that hello points to 
                                @ into register 1 

.data
@ The next line labels the location our string starts as `hello`
hello:       .ascii      "Hello World!\n" 
```
