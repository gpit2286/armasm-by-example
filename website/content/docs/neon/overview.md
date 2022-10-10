---
title: NEON Overview
weight: 1
---

# NEON Overview 

With all of the cool things computers can do these days, this may be one of the 
most exciting things. Many times in computing you need to do the same operation 
to a set of data. This could include color correcting pixels on a screen, 
running a cryptography algorithm, and determining reflection/blur results. For 
the longest time, processors were limited to calculating these with one instruction 
that resulted in one data point. (i.e., single instruction, single data or SISD) 
But NOW there are processors that can perform one instruction to transform 
multiple data points. (i.e., single instruction, multiple data or SIMD) The NEON 
co-processor in the ARM chips is their SIMD implementation. 

There is going to be a lot of information written below with very little examples. 
It is all important as NEON adds a lot of possibilities. For any question you 
have, [here is a link to the docs for the NEON co-processor](https://usermanual.wiki/Document/DEN0018Aneonprogrammersguide.1958102256/view) 
Also, worth noting, generally compilers and assemblers and analyzers are not 
great at detecting opportunities to implement this automatically and need at 
least some hints from the programmer. There are some libraries in different 
languages that can help, but again outside the scope of these lessons. 


## Registers 

If your chip has the NEON co-processor, it either also has the VFP or has the 
VFP integrated into the NEON co-processor.  For this reason, NEON uses the same 
registers that the VFP uses, but can also look at them from a larger view. 

NEON cannot address the S registers directly, but it can address the D registers 
directly.  In addition, it can look at the registers from a **Q**uad (128-bit) 
viewpoint that combines two D registers. 

```text
Not Addressable | D regs | Q Regs | 
    S0              D0      Q0
    S1
    S2              D1      
    S3
    S4              D2      Q1
    S5  
    S6              D3      
    S7 
    S8              D4      Q2  
    ... (Ends S31)
                    D31     Q15
                    D32
```

### Lanes 

NEON cannot do 128-bit math. The reason why it has space this large is because 
you can put data into "lanes" in order to do the parallel processing.  A 128-bit 
register can have: 

- 16 8-bit lanes 
- 8 16-bit lanes 
- 4 32-bit lanes 
- 2 64-bit lanes 

You can also use the D registers to provide 64-bit space total which will provide 
half of the above lanes for each dat size. 


## Mnemonics

Many of the same V operations can be used but the syntax is slightly different. 
The syntax is: 

```
V{<mod>}<instruction>{<shape>}{<cond>}{.<dt>} <dest1>{, <dest2>}, <src1>{, <src2>}
```

### \<mod\> 

This modifies the instruction on how to handle things like overflow and underflow. 
It can be one of the following or omitted: 

- Q (saturation): Each element in the result vector is set to either the maximum 
  or minimum if it exceeds the representable range. 
- H (halved): Each element shifted right by one place (effectively a divide by 
  two with truncation). 
- D (double): The opposite of halved. The doubling happens before any saturation 
  would take place. 
- R (rounded): The instruction rounds the result to correct for the bias caused 
  by truncation. This is equivalent to adding 0.5 to the result before truncating.

### \<shape\> 

When an operation is performed, there are always as many outputs as there are 
inputs. Sometimes the size of the data after an operation creates is different. 
(e.g., think about how it takes 32-bit to store two 16-bit numbers multiplied 
together) These are for those instances, but can be omitted if they don't apply. 

- L (long): Operands are the same width. Number of bits in each result element 
  is double the number of bits in each operand element. 
- N (narrow): Operands are the same width. Number of bits in each result element 
  is half the number of bits in each operand element.
- W (wide): Result and operand are twice the width of the second operand. 

### \<cond\> 

This refers to the conditional execution depending on CPSR settings. 

### .\<dt\>

This is the data type. This is similar to the way that the FPU used the `.f32` 
and `.f64` but refers to the lane size. They include: 

- U8, U16, U32, U64: unsigned integers 
- S8, S16, S32, S64: signed integers 
- I8, I16, I32, I64: unspecified integer 
- F16[^1], F32: floating point 
- P8, P16: [Polynomial over {0,1}](https://www.doc.ic.ac.uk/~mrh/330tutor/ch04s04.html)

[^1]: Not all NEON co-processors support F16. 

### Scalar data

Scalar refers to a single value instead of a vector containing multiple values. 
Some NEON instructions use a scalar operand. A scalar inside a register is 
accessed by index into the vector of values.

```armasm 
    vmov.i8         d0[3], r3   @ move r3 into the 4th byte of d0 
                                @ this is because it is zero indexed. 
```

## Compiling 

As with the FPV, you will need to tell the assembler that you are expecting a 
processor that has extended features. Below should work for most processors with 
fpu and NEON support. If it doesn't, you will need to find the exact match. The 
docs linked at the beginning of this lesson will help. 

```bash
as -mfpu=neon-vfpv4 -o main.o main.s
```


