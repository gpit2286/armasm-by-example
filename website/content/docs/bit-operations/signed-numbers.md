---
title: Signed Numbers
weight: 1
---

# Signed Numbers 

You may believe that I have made a mistake -- how could negative numbers appear 
under the section about "Bit Operations" and not "Arithmetic". It is because 
the way that the computer understands negative numbers has everything to do with 
manipulating bits in a certain way and less to do with negative numbers themselves. 

If you take the number 210 and write it out in individual bits, it would be 
`0b11010010`.  This is also the way that -46 is represented in 1-byte.  The 
processor, for all intents and purposes, has no idea if a number is negative or 
positive. It just knows `0b11010010`. 

## Signed v. unsigned 

When you hear someone talk about "signed" and "unsigned" numbers, this is exactly 
what they are talking about. Do you look at the series of bytes and interpret the 
number as possibly being negative or a larger positive number. In 1 byte, an 
unsigned integer can have the value of 0-255. If that single byte represented a 
signed integer, the range changes from -128 to 127. The signed values 128-255 are 
used to represent -128 to -1. 

## Calculating negative numbers "on paper" 

Some very smart people looked at computer bits and had this discussion: (probably)

- 1: Hey Fred, this computer is great. Can I put a negative number in there? 
- 2: Well, no. There's no negative numbers. They're all positive. 
- 1: That's not helpful. 

Person 1's name is John von Neumann and he discovered that you can use the same 
bytes and have them act like a negative number. 

Take the number -46 from above. Positive 46 is stored as `0b00101110`. The first 
step is to take all of the bits and flip them.  This would result in the binary 
becoming `0b11010001`. This is called **one's compliment**.  We then add 1 to the 
resulting number and get `0b11010010`. This is call the **two's compliment** and 
is the form that negative numbers take. Try adding one. 

```text
   0b11010010   -46
 + 0b00000001  +  1
 ==================
   0b11010011   -45
``` 

We can verify this by finding the two's compliment for 45. 

```text
0b00101101  45 
0b11010010  One's compliment 
0b11010011  Two's compliment. Same as -45 above.
```

And you should be able to add 46 and -46 together and get 0. (Wait. Right? RIGHT?!?!) 

```text
   0b00101110   46
+  0b11010010 +-46
====================
   0b00000000    0 
```

If you are astute, you may have noticed that there should have been a 1 that gets 
carried. You are correct. This 1 goes to the carry bit in the CPSR and is discarded 
from the register doing the addition. 

## Calculating negative numbers "in code" 

### MVN operation 

MVN is the mov not operation. This operation moves the inverse of the number you 
write. This makes it very easy to "flip the bits" of a number. 

You then just need to add 1, which you already need to do. 

```armasm 
   mvn      r0, #46     @ mov the opposite of 46 into r0. since this is 
                        @ actually a 32 bit register it now contains   
                        @ 11111111 11111111 11111111 11010001 
   add      r0, #1      @ add 1 to get two's compliment 
                        @ r0 now equals -46, which in the 32 bit space would 
                        @ look like this: 
                        @ 11111111 11111111 11111111 11010010
```