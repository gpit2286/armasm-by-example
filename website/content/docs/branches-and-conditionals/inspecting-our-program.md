---
title: Inspecting Our Program
weight: 5
---

# Inspecting Our Program  

There are at least two programs you can use to look at programs and debug.  First, 
compile the following program using the command `as -g -o main.o main.s`. What 
the -g flag will do is add debug symbols to the executable. The linker command 
will be the same as before. (`ld -o main main.o`)

```armasm 
.global _start 

_start: 

    mov     r4, #2      @ load 2 into r4 
    add     r4, #6      @ add 6 to r4 

```

## Object dump 

The first tool you can use is `objdump`. If you invoke it as `objdump -d main` 
you can see the actual commands that the assembler wrote to the file. For this 
simple program, the output is: 

```shell
pi@raspberrypi:~/hrm$ objdump -d main

main:     file format elf32-littlearm

Disassembly of section .text:

00010054 <_start>:
   10054:	e3a04002 	mov	r4, #2
   10058:	e2844006 	add	r4, r4, #6
```

The file format tells you that the file is an [elf](https://en.wikipedia.org/wiki/Executable_and_Linkable_Format). 
If you recall, the part of the program where all of the instructions are is the 
`.text` section, so that makes sense. You can then see the `_start` label and our 
two operations, MOV and ADD. 

This is helpful because sometimes the compiler will not use the same instructions 
that you think it is using. It will sometimes substitute some commands for others 
for various reasons. 

### Machine code 

Welcome to the nitty-gritty. In the end, the processor (and computers in general) 
only understands 1's and 0's. In the above example, under the `_start` label in 
the first column, you can see the relative address each instruction appears at. 
This makes sense that the first instruction is at 0x10054 and the next at 0x10058 
because each instruction is 32-bits or 4 bytes. 

The next column is the actual machine code instruction but in hex format. If you 
write it in binary, it would look like this: 

```
11100011 10100000 01000000 00000010
```

The processor then takes these ones and zeros and understands it as this. 

<table>
    <tr>
        <th>1</th>
        <th>2</th>
        <th>3</th>
        <th>4</th>
        <th>5</th>
        <th>6</th>
        <th>7</th>
        <th>8</th>
    </tr>
    <tr>
        <td>1110</td>
        <td>00</td>
        <td>1</td>
        <td>1101</td>
        <td>0</td>
        <td>0000</td>
        <td>0100</td>
        <td>000000000010</td>
    </tr>
</table>

1. Condition Code: 1110 = Always execute 
2. Always 00 for data processing 
3. 1 = Immediate operand at end as opposed to a register 
4. Opcode: 1101 = MOV 
5. Update CPSR: This would be 1 if we used an instruction with an -s suffix or 
   a command such as CMP. 
6. Rn = 1st operand register: Since MOV only has a destination, this is 0 
7. Rd = Destination register: 0010 = 4 
8. Operand2 = This was explained in the very beginning. Because the flag in field 
   3 is set, this is an immediate value. 0b10 = 3 

If you want to deep dive into decoding instructions, [they are all explained in the 
manual](https://iitd-plos.github.io/col718/ref/arm-instructionset.pdf). 


## GNU Debugger

The machine code is great for static analysis, but what if you want to inspect the program 
while it is running? The GNU Debugger (GDB) is a perfect tool to do this. There are 
a multitude of tutorials on how to use this tool as it has been in use for 
almost 35 years. Below is a quick overview but I would highly suggest 
[reading the documentation](https://www.gnu.org/software/gdb/documentation/) or 
[looking at a detailed cheatsheet](https://darkdust.net/files/GDB%20Cheat%20Sheet.pdf)

### Running a program 

To start gdb, just invoke `gdb application_name`. After it loads, you will see a 
very uneventful `gdb>` prompt.  To run the program and pause on the first operation, 
use `start`. If you would like to add any arguments, just add them after start. 
(e.g., `start arg1 arg2`) If you have set breakpoints, you can also use `r` or 
`run` to skip stopping on the first operation. The `q` command will exit GDB. 

### Setting breakpoints 

If you want to stop on a label, you can simply type `break labelname` or `b labelname`. 
If you're trying to set a breakpoint on a certain line, you can use the `l` command 
to show a list of the next 10 lines of the program.  You can then set a breakpoint 
by typing `b lineno`. To remove a breakpoint, use `d` as opposed to `b` with the 
same argument you used to set the breakpoint. 

### Leaving breakpoints 

After the program is stopped, you can: 

- c: continue running until the next breakpoint 
- s: Runs the next instruction (steps into function calls)
- n: Runs the next instruction (steps over function calls)

### Reading data

There are two primary ways to look at the values your program is using. The first 
is how you would [**examine** memory](https://sourceware.org/gdb/current/onlinedocs/gdb/Memory.html).

The other way is to look at variable values, or in assembly the register values, 
using [print](https://sourceware.org/gdb/current/onlinedocs/gdb/Data.html#Data). 

