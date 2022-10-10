---
title: Introduction
type: docs
---

## Overview 

Originally this was a pet project of mine that was going to follow the progress 
of the popular game, [Human Resource Machine](https://tomorrowcorporation.com/humanresourcemachine). 
However, after working out the exercises, I noticed that there was a lot of 
redundancy because of the fundamental difference of architecture. From there 
I started trying to figure out how to structure this course. 

Since the ARM architecture is a reduced instruction set computer (RISC), there are 
only about 30 operations that the main processor understands. What I ended up doing was 
listing them out, grouping them by function, and designing a better set of exercises 
that explored all of the operations. 

Within the exercises, I wanted to discuss some general concepts and how they 
relate to the assembly world. I tried to visit some important concepts that 
apply to all programming such as negative numbers and using bit logic to save processing cycles. 

I don't intend for this to be an "authoritative guide to all things ARM assembly," 
but rather a set of exercises and lessons that will allow you to start your 
journey getting closer to the bare metal. While much of this information could be used 
for embedded programming, there is a short section that is dedicated to interacting 
with a Linux operating system specfically. 


## Requirements 
- A computer with an ARM (32-bit) processor that is at least ARMv6. For reference, any Raspberry 
  Pi would work for this. 
- Be running a linux operating system. Raspberry Pi OS (previously called Raspbian) 
  is what I will use. 
- The following software **should** be installed by default. If not, it will be 
  needed 
    - GNU Compiler Collection 
    - GNU Make 
    - GNU Debugger (gdb)

## Extended Requirements 
- For the floating point example you will need an ARM processor with a FPU 
  co-processor (VFP)
- For the SIMD example, the processor will need the NEON co-processor

## The Future 

Below are some things that I would like to tackle in the future, but need to find the time. 

- 64-bit (AArch64) code guide 
- Thumb Mode guide 
- In depth floating point guide  
- In depth NEON co-processor guide 
- ASM FFI/inline support in other languages and vice versa

If you really enjoyed the content and would like to support me, the #1 way is to share the website with 
someone else that may enjoy it. If you really would like to go above and beyond, send me 
an email and let me know what you thought of this series. (kyle@kylebaldw.in) If you REALLY REALLY 
want to go above and beyond, you can send me a tip to let me know you would like to 
see more content like this in the future. 

* [Buy Me a Coffee](https://www.buymeacoffee.com/kylewb)
* Venmo: `@kwb--`

<img src="/img/venmo-qr.png" style="width: 150px" alt="Venmo QR Code for @kwb--"/>
