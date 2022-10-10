---
title: Shifting and Rotating
weight: 6
---

# Shifting and Rotating 

Shifting and rotating refer to the process of taking the bits of a number and moving them 
either to the left or the right. The ARM processor has a *barrel shifter* 
included in the hardware which allows you to shift the flexible operand2. 

## Rotating 

Rotating is the operation where when bits get to the end of the register, 
they move to the other side. There are two rotate instructions. 

### ROR operation 

```armasm 
    mov     r0, #0b11001100     @ r0 = 00000000 00000000 00000000 11111111 
    ror     r0, r0, #2          @ shift to the right 2 
                                @ r0 = 11000000 00000000 00000000 00111111
```

### RRX operation 

The RRX operation functions exactly like ROR, but instead of a 32-bit register, it 
treats the carry flag in the CPSR as a 33rd bit. It, however, can only move one bit 
at a time. 

```armasm 
    mov     r0, #0b11001100     @ r0 = 00000000 00000000 00000000 11111111 C = 0 
    rrx     r0, r0              @ shift to the right 1
                                @ r0 = 00000000 00000000 00000000 01111111 C = 1
                                @ if carry were 1 during move operation, it would 
                                @ have ended up in bit 31

```

## Shifts 

### Logical shifts 

The logical shift right (LSR) and logical shift left (LSL) shift bits and move 
the last removed flag to the carry bit of the CPSR if the s suffix is added.

```armasm 
    mov     r0, #0xff00ff00     @ r0 = 11111111 00000000 11111111 00000000  C=0 
    lsls    r0, r0, #10         @ r0 = 00000011 11111100 00000000 00000000  C=0

    mov     r1, #0xff00ff00     @ r0 = 11111111 00000000 11111111 00000000  C=0 
    lsrs    r1, r1, #10         @ r0 = 00000000 00111111 11000000 00111111  C=1
```



### Arithmetic shift 

You may see the problem with shifting -- it always moves zeros into the register. 
If you are still thinking about negative numbers, you can see why this would be an issue. 
If you add a zero to the front of a "negative" number, then it's not "negative" anymore. 
Because of this, there is also a arithmetic shift right (ASR) which will preserve the sign 
by copying the 31st bit and not just zero. 

```armasm  
    mov     r0, #-23        @ r0 = 11111111 11111111 11111111 11101001 C=0 
    asr     r0, r0, #4      @ r0 = 11111111 11111111 11111111 11111110 C=1 
```
