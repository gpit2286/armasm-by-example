---
title: Exorcise and bicycle orr...
weight: 3
---

# Exorcise and bicycle orr...

Now that you have started thinking about the individual bits that make up the 
data that you work with on a daily basis, there are a couple of operations that 
allow you to do this easily. 

## AND operation 

AND allows you to create a value that displays where both bits are set. 

| Val 1 | Op | Val 2 | Result | 
|:-----:|:--:|:-----:|:-------:|
| 0 | AND | 0 | 0 | 
| 0 | AND | 1 | 0 | 
| 1 | AND | 1 | 1 | 
| 1 | AND | 0 | 0 | 

The syntax is: 

```armasm 
    and     Rd, Rn, op2 @ Rd = destination, Rn = first value  
```

## BIC operation  

The BIC performs an AND on a value and the bitwise NOT of the second value. 

| | Val 1 | OP | Val 2 | Result |
|:-:|:---:|:-----:|:------:|:-----:| 
| | 0b11110000 ||  0b01010101 |  | 
| NOT | --- | | 0b10101010 | | 
| | 0b11110000| AND | 0b10101010 | 0b10100000 | 

The syntax is: 

```armasm 
    bic     Rd, Rn, op2 @ Rd = destination, Rn = first value   
```

## ORR operation 

This is a fairly easy operation that works as a logical OR. If either bit is set, 
then the resulting bit set will have the bit set. 

| Val 1 | Op | Val 2 | Result | 
|:-----:|:--:|:-----:|:-------:|
| 0 | OR | 0 | 0 | 
| 0 | OR | 1 | 1 | 
| 1 | OR | 1 | 1 | 
| 1 | OR | 0 | 1 | 

```armasm 
    orr     Rd, Rn, op2 @ Rd = destination, Rn = first value   
```

## EOR operation 

I try not to write in first person much, but this is my favorite operation. The 
exclusive or or XOR has some cool properties.  This will set a bit if only one 
bit of the pair is set. 

| Val 1 | Op | Val 2 | Result | 
|:-----:|:--:|:-----:|:-------:|
| 0 | XOR | 0 | 0 | 
| 0 | XOR | 1 | 1 | 
| 1 | XOR | 1 | 0 | 
| 1 | XOR | 0 | 1 | 

This is used in many different places in computing checksums, cryptography, random 
number generators, uniqueness detection... 