---
title: Branches and Loops
weight: 2
---

# Branches and Loops 

Now that you can write conditional code, you need to know how to move around the 
code in a non-linear manner.  Assembly only has one such concept and that is 
branch. Branch is just like GOTO in languages that support it. 

```armasm
    mov     r0, #2      @ Move 2 into register 0
loop:  
    add     r0, #1      @ Add 1 to r0 
    b       loop        @ return to loop label 
```

As you can see above, when we branch we will branch to labels. This is another 
time where the compiler and linker will turn the label into a relative address 
while it's being compiled. (You could write an offset to branch to, but it's a 
lot less practical.) This first loop would be beneficial if you were writing 
something that never stopped, but this isn't practical for much of what you'll 
program. 

## IF statements 

The most fundamental conditional concept you may come across is the if statement. 
Because there is no `if` keyword, the code will look similar to this: 

```armasm 
    mov         r0, #10     @ Move 10 into register 0 
    mov         r1 ,#7      @ Move 7 into register 1
    
    cmp         r0, r1      @ Compare r0 and r1 
    bne         lblne       @ If r0 != r1, branch to lblne 
    add         r1, #3      @ else add 3 to r1 
    b           lblexit     @ Go to end of code 
lblne:
    add         r0, #3      @ Add 3 to r0 
                            @ don't need to branch to lblexit here as it's the 
                            @ next command 
lblexit:
    @ Continue code.... 
```

With this you can then start making loops. 

## WHILE loop 

```armasm 
@ While r0 < 5 

loop: 
    cmp     r0, #5      @ Compare r0 and 5 
    bge     exit        @ If greater than or equal, exit loop 
    @ Do loop operations here 
    b       loop 
exit: 
    @ continue with code 
```

## FOR loop 

```armasm 
@ For each r0 = 0 to 5 
    mov     r0, #0      @ Mov 0 into r0 as first number 
loop:
    cmp     r0, #5      @ Compare r0 to 5 
    bgt     exit        @ Leave loop if r0 > 5 
    @   Do loop operations here 
    add     r0, #1      @ Increment counter 
    b       loop 
exit: 
    @ continue with code 
```

