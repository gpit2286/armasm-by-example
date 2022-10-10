---
title: "Program 15: The Un-sale"
weight: 8
type: programs

description: |
    The shop I own (I don't) had a sale but some employee decided to not write down the original 
    price of all of the items! Well, it's simple because all of the prices are 1/3 of their 
    original amounts. The problem is I have a billion prices so I need to figure out 
    how to get the original price as quickly as possible!!! Take the list of prices and 
    output the original price. No need to output the discounted price. 

    Your input is in the template file. 

source: https://github.com/gpit2286/armasm-by-example/tree/master/15-unsale
youtube_id: "bzYcJhfBJmo" 
input: https://github.com/gpit2286/armasm-by-example/tree/master/15-unsale/template
output: |
    2733
    2607
    1698
    2874
    2361
---

## Multiply by \<base\> 

In decimal, it's really easy to multiply by 10.  You just simply add a 0 to the end of 
the number. 

```text
3 * 10 = 30  
30 * 10 = 300 
``` 

Boom. Did you know this works in every base? 

```text
0x1 (1) * 16 = 0x10 (16)
0x10 (16) * 16 = 0x100 (256) 
```

Boom. You can take this knowledge and combine it with left shifts to multiply by 2 easily. 

```text
2 (0b10) * 2 = 0b100 (4) 
4 (0b100) * 2 = 0b1000 (8) 
8 (0b1000) * 2 = 0b10000 (16) 
16 (0b10000) * 2 = 0b100000 (32) 
```

And right shifts? Divide by two! 

## RSB operation 

Generally the SUB operation is great. You have a number and you want to subtract 
another number, works perfect.  Sometimes though, it may be beneficial to put the 
"larger" number in the operand2.  This would allow you to do things like shifting a 
value and then subtracting from that. The ARM processor has such an operation call 
RSB or reverse subtraction. 

```armasm 
    rsb     r0, r1, r2      @ subtract r1 from r2 and store in r0 
                            @ r2 can be any form of the operand2 
```

## Note on pre-optimization 

One trap I think many programmers fall into (myself included) is to optimize a program 
before there is a problem. Sometimes it's only by doing the "wrong and slow" way that you 
realize that it's actually okay. There are also some times where the compiler will 
use intermediate steps (e.g., LLVM) and optimize it better than you could. 
However, for this problem, I'm asking you to pre-optimize on purpose. 

It would be very easy to write this: 

```armasm 
    mov     r1, #3          @ this only needs to be done once to mul by reg 
    mov     r0, #5          @ this would be once per loop 
    mul     r0, r0, r1      @ mul r0 * r1 (3) and store in r0 
```

MUL will take a maximum of 5 processor cycles depending on number size. 
While writing small programs this isn't a problem. If you're writing a program 
that will process billions or trillions of operations, it can add up. (Think possibly 
a transform on a video stream) The ARM processor that is inside the Raspberry Pi 
I use for writing these programs has a 900MHz processor. That is only 180,000,000 
multiplications a second at its slowest. This is where getting creative can pay off. 

There is a way that only takes 1 cycle[^2]. 

If you wrote this: 

```armasm
    mov     r1, #3              @ this is once per loop again
    rsb     r0, r1, r1 lsl #2   @ essentially 4(r1) - r1 
```

The reverse subtract, even with the shift, would only take one cycle. This is 
because the barrel shifter is outside of the ALU and will do some of the 
heavy lifting here. There are some limitations as this wouldn't work with float 
numbers (you shouldn't be using float numbers for currency anyway 🤷‍♂️), the numbers 
you use would need to fit inside the first 30 bits so the shift didn't lose data, 
etc. Doing this, though, would only take (at best) 1/5th of the time 
and 1/2 the time at worst

[^2]: 99% sure from the spec. Please correct me if it's not