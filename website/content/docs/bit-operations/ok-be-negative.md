---
title: "Program 12: Ok, Be Negative"
weight: 4
type: programs

description: |
    I've realized that it's okay if more of my friends have negative happiness scores. 
    I mean, I want them to be happy. But I want to make sure that they are surrounded 
    by people who feel the same way as them. And actually I decided to include 
    everyone on my Facebook account and increase the happiness score to a 2-byte number. 

    In the list of numbers, count the number of consecutive pairs of numbers where 
    the happiness score is either both positive or both negative. 

    Example: 

    Input: 2, 3, -2, -3, -4, 2 
    Output: 2 -- (2, 3) and (-2, -3) would match the pattern 

source: https://github.com/gpit2286/armasm-by-example/tree/master/12-ok-be-negative
youtube_id: "hCL0oh_NdLM" 
input: https://github.com/gpit2286/armasm-by-example/tree/master/12-ok-be-negative/template
output: "27"
---


## Using XOR for sign detection 

With signed integers, the most significant bit will always be 1 if the number is 
negative. Try XOR-ing two negative numbers in our imaginary 8-bit registers. 

```text
    0b11110110  -10
XOR 0b11011110  -35
=====================
    0b00101000
      ^--- First bit 0 
```

If you take a negative and a positive number, this happens. 

```text
    0b11110110  -10
XOR 0b00000010    2
=====================
    0b11110100
      ^--- First bit 1
```

This is helpful because the N flag of the CPSR is a mirror of the most significant bit.

## TEQ operation  

As the CMP operation compares two numbers by subtraction and then sets the CPSR, 
there are a couple of other comparison operations that perform and operation and 
discard the result. Of of those is the TEQ operation which compares a EOR (XOR) 
on two operands and sets the CPSR based on the result. 

