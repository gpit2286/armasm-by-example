---
title: "Program 6: Sticky Keyboard"
weight: 4
type: programs

description: >
    My keyboard sucks. Thanks Apple. The keys stick badly. (They don't really 🤷‍♂️)
    Write a program that takes a string and removes the duplicate letters. 
source: https://github.com/gpit2286/armasm-by-example/tree/master/06-sticky-keyboard
youtube_id: "QpgesZ6bzuo" 
input: https://github.com/gpit2286/armasm-by-example/tree/master/06-sticky-keyboard/template
output: "I just want this stupid thing to work!"
---


 
Are you tired of adding one all the time to increment memory addresses? What if 
I told you there was a better way? A way where you didn't need the ADD opcode. 
A way that allows the processor to work in less cycles?!?!?!? 
Now for <span class="blink_text">$19.95</span> I will show you the secret to be 
more efficient. Or you could just read below. 

## Incrementing LDR/STR instructions 

### Offset address 

The first method is to alter the address before the LDR or STR operation happens. 
When you use this syntax, the change in address does **not** write a new value to 
the address register. There are some use cases for this such as looking ahead in memory. 

```armasm 
    ldr         r0, =address        @ pretend the address loaded is 0x1000
    ldrb        r1, [r0, #2]        @ this would load the byte at 0x1002 to r1 
                                    @ r0 still equals 0x1000 
```

### Pre-index address

By using this method, the address with be adjusted before the LDR/STR operation 
(as above) however it will then write this address to the address register. The only 
difference is the addition of an `!` after the offset. 

```armasm 
    ldr         r0, =address        @ pretend the address loaded is 0x1000
    ldrb        r1, [r0, #2]!       @ this would load the byte at 0x1002 to r1 
                                    @ r0 would then be set to 0x1002 
```

### Post-index address 

This is the form that you will see most often.  This will allow you to read an 
address and then offset the address value after the LDR/STR. 

```armasm 
    ldr         r0, =address        @ pretend the address loaded is 0x1000
    ldrb        r1, [r0], #2        @ this would load the byte at 0x1000 to r1 
                                    @ r0 is then set to 0x1002 
```

