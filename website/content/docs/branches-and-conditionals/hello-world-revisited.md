---
title: "Program 5: Hello World Revisited"
weight: 3
type: programs

description: >
    Write a program displays "Hello World!" and exits with the error code 0. 
    For the writing of the string, use a macro that prints using a null 
    terminated string. 
source: https://github.com/gpit2286/armasm-by-example/tree/master/05-hello-world-revisited
youtube_id: "Gvh9mKpvhKo" 
# input: https://link to resource 
output: "Hello World!"
---



## Including Other Files, Pt. 1

### MACRO directive 

Putting everything in one file is great keeping code together, but absolutely awful 
for more than trivial programs as the number of lines of code grows rapidly. There 
are two ways you can include code in from other files and this is the first way. 
Like a keyboard macro, the MACRO directive puts an exact copy of the code at the 
point of inclusion. 

```armasm 
@ the syntax is .macro followed by the name of the macro followed by a 
@ comma seperated list of arguments expected. 
.macro      macroname       arg1, arg2, arg3          

    @ arguments are inserted in the code with a backslash 
    mov     r0, \arg1           @ loads the immediate into r0 

@ macros are ended by the .endm directive 
.endm 
```

### Local labels

Since the macro includes the code verbatim, you need to consider what would not 
work as if everything were in one file. One such instance would be labels as they 
need to be unique within the **file**. We can accomplish this by using local labels. 
Local labels are a number from 0-99 followed by a colon. You can then append either 
a -f or a -b to look for that number forward or backwards. 

```armasm 
1: 
    add     r0, #1      @ add 1 to r0 
    cmp     r0, #5      @ compare 0 to 5 
    beq     2f          @ go on if equal 
    b       1b 
2: 
    @ Code continues.... 
```

### INCLUDE directive 

The last part of this is to actually include the file that has the macro if we 
put it in an external file. We do this with the include directive. The include 
directive simply includes the file, in the exact space, as if it were the same file. 


## Null terminated strings 

When you use a macro, you start getting into an area where you need to trust the 
person using your code to provide things such as output memory space. So we need to 
create a macro that can be used in any program, even if we don't know the length. 
One way programs do this is by null terminated data. It's such a great idea, there's 
a macro for that too! The two following data items will load the same data into memory. 

```armasm  
.data
explictnull:        .ascii      "String with null\0" 
datanull:           .asciz      "String with null" 
```
