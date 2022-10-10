---
title: Memory Overview
weight: 2
---

# Memory overview 

When someone says that a computer has "memory," it could be a number of things.
 There are all kinds of media that fall under this category. Any peripheral 
outside of the processor that stores data can be considered memory. In addition to 
the RAM, there may be ROM (read only memory), EEPROM (electrically erasable 
programmable read-only memory), flash drives, disc drives, tape cassettes... 
In this series, when we talk about memory, we will always be talking about RAM 
unless specified otherwise. 

When you access RAM, you need to provide an address for the byte you're trying to 
read.[^1] Most of the the time, the compiler will compute these relative addresses 
for you when we use labels to refer to data. So why do you need to worry about this? 
Eventually you will start debugging the programs you write, and you may be surprised 
to see that everything in memory looks backwards. This is because, be default, the 
ARM processor stores bytes in memory by little endian. 

[^1]: If you want to really understand how and why this works, I HIGHLY suggest 
watching the [Ben Eater Videos](https://www.youtube.com/playlist?list=PLowKtXNTBypGqImE405J2565dvjafglHU) 
on building a computer from scratch. 

## Endianness

There are many resources already that talk about endianness and I do not look to 
offer something novel in this aspect. However, providing a quick explanation is 
prudent if this is a new concept. 

When computers address memory, they can do so in two ways. They can either increment 
the address or decrement the address for "the next byte" of data. However, within 
a byte, the bits will always be in the same direction with the most significant bit, 
or the bit with the highest value, on the far left. If we're storing the value 
`0x0A0B0C0D`, it would be stored like this.[^2]

[^2]: Graciously stolen from [Wikipedia](https://en.wikipedia.org/wiki/Endianness). 


{{< columns >}}

![Big Endian Example](/img/big-endian.png)

<--->

![Little Endian Example](/img/little-endian.png)
{{< /columns >}}


## Registers v. Memory 

The main points you need to remember about registers and memory are: 

- Memory is outside of the processor, registers are inside the processor 
- Registers are needed to operate on data as processors cannot directly operate on data 
  inside memory of any sort.
- Registers are addressed by `r` and a number, memory is addresses by numbers that 
  look like 0x600f. 
