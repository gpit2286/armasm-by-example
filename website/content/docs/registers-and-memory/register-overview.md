---
title: Register Overview
weight: 1
---

# Register overview 

As mentioned before, the registers are inside the processor and allow the processor 
to operate on data. The ARM processor can not do calculations or manipulate data 
directly inside the memory. The ARM processor has 16 32-bit registers (r0-r15). 

## Sane register usage 

While technically you can use every register, some of the registers are reserved for  
specific functions. 

- r0 - r12: General purpose - Use without care of reserved functionality 
- r13: Stack pointer - Address location of stack in memory
- r14: Link register - Address location of where to return to after branch 
- r15: Program counter - Address location of "next" operation to perform 

And then, within the general purpose registers, there are some soft rules. 

- r0-r3 is generally reserved for calling functions 
- r4-r12 is generally safe to preserve data after/during function calls 

{{< hint warning >}}
The most important take away: Don't use r13-r15 unless you really understand what you're doing.
{{< /hint >}}

  

## The 17th register   

Ok, I lied a little. There is a 17th register called the Current Program Status 
Register (CPSR). The CPSR keeps track of things that the processor needs to know 
when executing operations. It keeps track of things like condtional states, 
endianness, thumb mode enabled, interrupt flags, processor mode, etc.

For right now, of the 32-bits in the register, you only need to worry about bits 
28-31. These bits will allow you to start writing conditional operations soon. 

- 31: **N**egative: If N is 1 the signed value is negative, and cleared if the result is positive or zero.
- 30: **Z**ero: set if the result is zero
- 29: **C**arry:
	- With the instructions ADC, ADD, and CMN, this flag is set if the result would produce an unsigned overflow.
  - With the instructions CMP, SBC, and SUB, this flag is set if the result would **not** need a borrow from an imaginary bit.[^1]
  - For other instructions that use shifting, this flag is set to the value of the last bit shifted out by the shifter.
  - Other instructions usually leave this flag alone. 
- 28: o**V**erflow: for addition and subtraction, this flag is set if a signed overflow occurred. Otherwise, it is generally left alone. Note that some API conventions may specifically set oVerflow to flag an error condition. 

[^1]: I think of this as this is the bit that would be borrowed from for subtraction operations. 