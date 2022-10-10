---
title: FPU Overview 
weight: 1
---

# FPU Overview 

In addition to the core processor, there can exist an optional co-processor 
that works with floating point numbers. Since the release, this co-processor 
has become almost synonymous to the NEON co-processor which you will learn about 
in the next appendix.  

## Mnemonics

Many of the instructions you used with the core processor exist in the FPU, but 
they are prefixed with a 'V'.  [A full list is here](https://developer.arm.com/documentation/ddi0439/b/Floating-Point-Unit/FPU-Functional-Description/FPU-instruction-set). You'll also 
notice that many of them require you to specify if you want to use 32-bit (single) 
or 64-bit (double) precision. You also get to use a new square root instruction! 

## Registers 

There are 32 32-bit registers that can also be addresses as 16 64-bit registers. 
The 32 32-bit registers are labeled as s0, s1, s2, etc for **S**ingle precision.  
Likewise the double registers are labeled d0, d1, d2, etc. for **D**ouble precision. 
Because of this, s0 and s1 combined are the same as d0 and likewise throughout 
the registers. (e.g., s2 and s3 are the same as d1, s4 and s5 are the same as d2)

## Data section 

With these new data types, you need new directives to load numbers into memory. 
This is done with the following: 

```armasm 
.data  
numone:         .single     1.223, 1.223    @ single precision floating numbers 
numtwo:         .double     1.223, 1.223    @ double precision ""       ""
```
## Compiling 

Compiling the programs you write with floating point support requires one change. 
When using the FPU you need to tell the compiler which version of the FPU you want 
to use. For all Raspberry Pi's, this will work: 

```bash
as -mfpu=vfp -o main.o main.s
```

## Quirks

### Rounding errors 

You may already know about this problem.  When you take a number and display it 
in a floating point fashion, you are bound to get rounding errors. This is because 
the computer doesn't store numbers in a decimal fashion, it uses binary. This can 
be mainly avoided by using a fixed point decimal -- but that is not what you have 
here. You want an example? Go find your favorite language that uses floating point 
numbers, and have it evaluate `0.2 + 0.1` Your answer more than likely will be 
`0.30000000000000004`. You will learn more about this in the exercise. 

### NaN

The concept of not a number doesn't really exist core processor. Because everything 
can be interpreted in the series of bits, everything can be a number. However, in 
floating point numbers, you can have a set of bits that doesn't make a floating 
point number. For instance, taking the square root of a negative number produces 
a number + *i*. The way you can detect that the processor didn't complete an 
operation successfully is that the exponent number will be all 1's. 

