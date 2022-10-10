---
title: Conditionals
weight: 1
---

# Conditionals  

There was a brief mention about the status codes stored in the CPSR. This is when 
you get to start using them. Because assembly doesn't have the concept of data types, 
the processor needs to figure out another way to define conditions such as equal, 
not equal, greater than, less than or equal, etc. It does this by looking at the 
flags of the CPSR. 

## Comparison methods 

The first thing you need to do is to tell the processor that you want it to update 
the CPSR. The first opcode you will use is `cmp`.  `cmp` takes the two operands and 
subtracts the second from the first. From this result, it will then update the CPSR. 

```armasm 
    mov     r0, #5          @ Move 5 into r0 
    mov     r1, #2          @ Move 2 into r1 
    cmp     r0, r1          @ Compare r0, r1 and set CPSR 
```

From this, we now know that the processor will subtract 2 from 5, and use the result (3)
to set the correct flags. 

- The N flag will not be set because the number (3) is not a signed negative. 
- The Z flag will not be set because the number (3) is not zero 
- The C flag will be set because we didn't not need to do an imaginary borrow to solve
- The V flag will not be set because there was no overflow (greater than or equal 
  to 2<sup>31</sup>, or less than –2<sup>31</sup>)

### The -S suffix 

The other common way to set the CPSR flags is by appending an -s suffix to an opcode. 
Not all opcodes can take the -s suffix, but most can. It's always worth checking the 
processor guides when in doubt.  The CPSR will be set based on the result of the operation. [^1]

[^1]: Since CMP uses subtraction it is essentially using the SUBS opcode. The 
difference is that SUBS will save the result, CMP discards it. 

```armasm 
    mov     r0, #2      @ move 2 into r0 
    mov     r1, #1      @ move 3 into r1 
    adds    r0, r1      @ adds 2 and 3 stores into r0 
                        @ ALSO sets the following flags based on the number 5
                        @ N = 0 because 5 is not signed negative 
                        @ Z = 0 because 5 is not zero 
                        @ C = 0 because there was no carry 
                        @ V = 0 because there was no overflow 
```

## Conditional table 

From there you can see how the processor interprets the results with this table. 
Using the table, you can see that because of the flags set above, the following 
conditions are true for 5 - 2: 

- The two numbers are not equal (Z == 0)
- The first number is signed greater than (Z==0) && (N==V) 
- The first number is signed greater than or equal (N==V) 
- The first number is unsigned higher or same (C==1)
- The result is positive (N==0)
- There was no signed overflow (V==0)
- The first number is unsigned higher (C==1) && (Z==0) 

|Condition Code |	Meaning with `cmp` |	Status of Flags|
|:-----:|:------------------------|:-----:|
| EQ 	|Equal |	Z==1|
|NE |	Not Equal| 	Z==0|
|GT |	Signed Greater Than |	(Z==0) && (N==V)|
|LT |	Signed Less Than |	N!=V|
|GE |	Signed Greater Than or Equal |	N==V|
|LE |	Signed Less Than or Equal |	(Z==1) || (N!=V)|
|CS or HS |	Unsigned Higher or Same (or Carry Set) |	C==1 |
|CC or LO |	Unsigned Lower (or Carry Clear) |	C==0 |
|MI |	Negative (or Minus) |	N==1|
|PL |	Positive (or Plus) |	N==0|
|AL 	| Always executed |	 N/A |
|VS |	 Signed Overflow |	 V==1|
|VC |	 No signed Overflow 	| V==0|
|HI |	 Unsigned Higher |	(C==1) && (Z==0)|
|LS |	 Unsigned Lower or same |	 (C==0) || (Z==0)|

## Conditions in practice 

From here, you can use these condition codes and affix them to most opcodes! 

```armasm 
    mov         r0, #5      @ Move 5 into r0 
    mov         r1, #7      @ Move 7 into r1 
    cmp         r0, r1      @ Internally performs 5-7 and updates CPSR 
                            @ based on result (-2), 
                            @ specifically Z = 0 in this case 
    addeq       r0, #10     @ Will NOT add 10 (eq requires Z == 1)
    addne       r0, #5      @ Will add 5 (ne requires Z == 0) 
```