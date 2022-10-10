---
title: "Program 8: ITOA"
weight: 4
type: programs

description: >
    If you are going to print numbers to stdout, you need to come up with a way to 
    convert those numbers into an ASCII representation. For now, just worry about 
    unsigned numbers. 

    Write a program that loads the number 209867295 and writes it to stdout. 
source: https://github.com/gpit2286/armasm-by-example/tree/master/08-itoa
youtube_id: "qhzgANi7W4o" 
input: https://github.com/gpit2286/armasm-by-example/tree/master/08-itoa/template
output: "209867295"
---

 

## EQU directive 

While you don't have variables in the standard sense, there is one naming thing 
you can do. You can use the EQU directive to define a read only *number*. 

```armasm 
.equ    var1, 128 

mov     r0, #var1 
```


