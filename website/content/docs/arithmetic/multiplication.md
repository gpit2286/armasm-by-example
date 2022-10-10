---
title: Multiplication
weight: 3
---

# Multiplication 

When a processor does multiplication, it doesn't quite do multiplication in the 
way you can do it in your head. [It uses a process you probably wouldn't think about](https://en.wikipedia.org/wiki/Booth%27s_multiplication_algorithm). 
In fact, with the ARM processors, every multiply operation takes at least ~4-6 cycles.

## MUL operation 

The MUL operation is the "basic" multiplication operation. It takes the format 
`mul Rd, Rn, Rm` where Rd is the destination and Rn and Rm are input registers. 

{{< hint warning >}}
This opcode, as well as all of the other multiply opcodes, only take registers 
as inputs: there is no possibility to use the flexible operand2. 
{{< /hint >}}

## MLA operation 

MLA stands for multiply and accumulate. As it sounds, this operation multiples two 
registers and then adds the value to another register. The format is `mla Rd, Rm, Rs, Rn` 
where Rd = (Rm * Rs) + Rn. 

You may have (or many not have) realized something. If you take two 32-bit numbers, 
multiply them together, you will possibly get a number that takes up more than 32-bits. 
The above operations (MUL, MLA) will only return the 32 least significant bits. 
The 32 most significant bits are discarded. For that reason, there are the following 
operations. 

## MULL and MLAL operations 

These are the "multiply long" and "multiply long and accumulate" operations. However, 
to complicate things a little more, they never exist in this form. They are always 
prefixed with a 'U' and a 'S' to indicate unsigned or signed multiplication. 

```armasm 
    umull       r1, r2, r3, r4      @ r3 * r4, store high bits in r2, low in r1 
    smull       r1, r2, r3, r4      @ same as above, but for signed numbers 
    umlal       r1, r2, r3, r4      @ (r3 * r4) + (r2,r1) 
                                    @ high bits in r2, low bits in r1 
    smlal       r1, r2, r3, r4      @ same as above, but for signed numbers        
```

## SMULxy and SMLAxy operations 

Only because your head isn't spinning enough, you can add letters to the end of the 
signed multiplication opcode to multiply two 16-bit integers and store them in a 
32-bit register. The x and y can either be a t or a b to indicate the top or bottom 
half of the registers. 

```armasm 
    smultb      r1, r2, r3      @ multiply the top 16 bits of r2 and the 
                                @ bottom 16 bits of r3 and store in r1 
    smulbb      r1, r2, r3      @ multiply the bottom 16 bits of r2 and the
                                @ bottom 16 bits of r3 and store in r1
```

