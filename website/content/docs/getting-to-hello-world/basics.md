---
title: The Basics 
weight: 1
---

# The Basics 

## Dependency Check 

The first thing that we need to do is check to make sure that we have all of the 
correct tools that we need. The below table will tell you the program name, the 
command to check to make sure that it is installed, and what package includes the 
tool if it isn't present. 

| Program Name | Check Command | Required Package | 
|--------------|---------------|------------------|
| GNU Assembler | `as --version` | binutils       | 
| GNU Linker    | `ld --version` | binutils       | 
| GNU Debugger  | `gdb --version` | gdb           | 
| Make          | `make --version` | make         | 


## Syntax 

The first part of writing programs is understanding the syntax 
of the language.  Assembly is, maybe unsurprisingly, a little less descriptive 
than any other language you've worked with before. 

### Mnemonics 

Since we are using a language that interacts almost directly with the processor, 
there are two ways to write the commands. The first way is the manually write 
every 32-bit command in binary or hex. You can imagine that this is not sustainable. 
The second way is by using mnemonics that represent those 32-bit instructions. 

There are essentially three types of mnemonics or opcodes. (Rd = destination, Rn = source, 
op2 can be a register or an immediate)

- Some opcodes don't produce a result
  - `opcode Rn, op2`
- Some opcodes only deal with single registers 
  - `opcode Rd, op2`
- Some opcodes produce a result from a source 
  - `opcode Rd, Rn, op2` 

### Registers 
 
If I asked you to name the places that data "visits" inside of a computer, you would 
probably mention the hard drive/SSD and the RAM (or "memory"). There are also places 
inside the processor itself that the data "visits." One of those places are the registers. 
There are some registers that are used for general purpose and some that are 
used for specific reasons. For now, just know that the registers are the places 
inside the register where we can actually do operations on a piece of data. They 
are represented as `r0` - `r15`. 

### Immediate Values 

Assembly doesn't have the idea of a constant or really even variable assignment. 
In many programming languages we can think of a constant as a value that isn't 
allowed to change. There is no such safeguards in assembly. So how do we write 
the values that we want to use that are not calculated? Immediate values are the answer. 

If we think about an operation that the processor consumes, there is a lot of data 
that gets thrown into those 32-bit. Because of this, immediate values are, by space 
alone, limited to numbers 0-255 (unsigned). They are entered with a # sign followed 
by a char in single quotes or a number in binary, octal, decimal, or hexadecimal. 
So we can always use: 

- An integer from 0 - 255 
- A char value from ASCII by enclosing it in single quotes 

As you can see, this is quite limited. So the designers of the processor added a 
barrel shifter into the CPU and we can then take that base range (0-255) and shift 
it. All of these values would be possible: 

- 0x000000FF: 255, no shift 
- 0x00FF0000: 255, left shift 16 for a value of 16,711,680 
- 0x000FF000: 255, left shift 12 for a value of 1,044,480 

These would NOT be possible: 

- 0x00234500: Rotated value (0x2345) too large 
- 0x000007F8: Rotated value (0xFF) rotated an odd number of places 
- 0x000001FF: Base value too large 

What if we really really really needed 0x00FF0001? Compilers will transparently "fix" this for you by 
loading this value into memory when the program is loaded and load it into the 
register when needed. The downfall of this is that it takes an extra operation or two. 
The good thing? It only really translates into 1/500,000 of a second more or less. 


## File Format 

Unlike many programming languages, the format fo the file is quite simple.  There 
is a "main" function that is labeled as `_start`. Every program needs to have one 
and only one `_start`. This is, however, not an actual function but actually just 
a label. (If you've ever had GOTO nightmares, welcome back.)

There also needs to be two sections in the code. The first is `.text`. This tells 
the compiler where the operations live. Also, anything that is written in this 
section will never change when the program is running. The `.text` directive is 
usually omitted as the compiler assumes its existence. The other section is the 
`.data` section. This loads values that cannot be entered as immediate values and 
can reserve space for our program to use during execution. 

The last global directive is `.global`. This exposes labels from the code to the 
compiler and linker. For now, we will just be exposing the `_start` label. Below 
is an example source code file that will run, but produce no results. 


```armasm
@ At signs are the comment marker. In assembly, you'll 
@ use these on almost every line. They are the only way 
@ to keep things logical. 

@ The next line tells the linker that a function is available 
@ in a file. 
.global _start 

@ Every program needs a _start label.  This is where the program 
@ will start. It does not need to be at the top of the file. 
@ Maybe there is another function above this. Notice that a label 
@ is defined by text followed by a colon. 
_start: 

@ The next line is a valid command though it's not going to do much 
@ for you. The operation code is add which will add two numbers. The 
@ two operands, r2 and r3, are registers. We will talk about them in 
@ the next section. I generally indent op-codes one tab so that 
@ they don't look like labels. 
    add		r2, r3          @ Add r2 to r3 and store in r2 


@ The next line is a section marker. Even though it looks like 
@ the global directive, this just tells the compiler what data 
@ will be loaded when the program is loaded into memory. 
.data 

@ Within the data section, we will use labels to label data in the 
@ same way we can label operations. There are multiple data types 
@ but for this example, we will label a "Hello World" string 
@ as hello. The .ascii is a data type that will tell the compiler 
@ how to interpret the data. 
hello:		.ascii		"Hello World" 
```