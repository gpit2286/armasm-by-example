---
title: The Stack
weight: 5
---

# The Stack 

We spoke before about the different places that data can live, now we will dive into 
how those places are used. Hard Drives/SSDs are use to store data "long term." And by 
long term I mean generally longer than the invocation of a program. It's also used for files 
that are exceptionally large. 

Within the RAM, there are two primary areas: the stack and the heap. These concepts are 
constructs of the operating system. The processor doesn't understand stack and heap in the
same way the processor doesn't understand negative numbers. Because of this, it is up 
to the programmer in lower level languages to understand how to use these tools.[^1] 

[^1]: Heap management is getting way more into the nitty gritty that this assembly 
course plans to get into. This is highly studied and is very case dependant on which is 
best to use for certain situations. ["Light" reading for those interested.](http://www.adms-conf.org/2019-camera-ready/durner_adms19.pdf)


## How Linux uses the stack  

When a program is started, it is allocated a space in memory (RAM) where it can 
store data that it is working with. This memory follows a Last-In-First-Out model. The amount of 
memory that is allocated to the running program is determined by the operating system.  The 
other oddity is that the stack "grows" *down*.

Here is an example: 

| Address | Order Added | 
|---------|-------------|
| 0x0100  | 1st | 
| 0x00FC  | 2nd | 
| 0x00F8  | 3rd | 
| 0x00F4  | 4th | 

### Stack Pointer 

There was a small warning when talking about the registers that said "don't touch r13!" r13 is what is called 
the stack pointer. This is simply an address to a place in RAM where the last value was put in the stack. 
When we put data into the stack, or remove data, we need to make sure this pointer is moving to the correct 
place in order to avoid memory leaks. Some commands, like push and pop below, do this for us automatically. 
Other situations, like managing stack frames, may require a little more interaction. 

## PUSH and POP operations 

 To get information on and off the stack, we can **push** and **pop** the values. When we use 
 the push and pop commands, we are really just calling the store multiple (STM) and load multiple 
 (LDM) instructions with a little syntax sugar.[^2] You can either push/pop a single register or multiple ones. 

[^2]: More specifically STMDB and LDMIA or decrement address before store and increment address after load, where address refers to the stack pointer. We'll get there in a second. 

```armasm 
    push    {r0-r3}     @ pushes (saves) r0-r3 onto the stack 
                        @ above can also be written
                        @ push {r0, r1, r2, r3} 
    add     r1, #2      @ adds 2 to r1 
    pop     {r0-r3}     @ pops (loads) r0-r3 from the stack 
                        @ this would negate the add function 
                        @ and restore r0-r3 to their previous 
                        @ values from the stack 
```