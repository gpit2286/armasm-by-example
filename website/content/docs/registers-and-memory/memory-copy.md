---
title: "Program 4: Memory Copy"
weight: 4
type: programs

description: >
    My friend's cat is named Summer. I want to tell the whole world his name, but 
    first I need to copy it to send! (Look, coming up with creative prompts is hard. 
    Just do the exercise. 🤫) Using the below starter data section, write a program 
    that will copy the input string and output it to stdout. 
source: https://github.com/gpit2286/armasm-by-example/tree/master/04-memory-copy
youtube_id: "KSHQzW8Sxu4" 
input: https://github.com/gpit2286/armasm-by-example/tree/master/04-memory-copy/template
output: "SUMMER"
---

## Reserving Space, Pt. 2

Sometimes (read most of the time) you probably won't know the length of the output 
or exactly how much space you will need for the program. As opposed to writing 
a string in memory, you can use the fill directive to reserve space. The syntax is 
\# of data parts to reserve, the size of the space to reserve, and the value to 
store in that space. If the default value is not provided, it will default to 0 (integer). 
If you provide the size of each data repeat, it must be 1, 2, or 4 referring 
number of bytes. If the size is omitted, it is assumed to be 1 (byte).[^1] There are other ways 
to reserve memory through the operating system, but they are outside the scope of this course. 

```armasm  
label:      .fill   128         @ reserves 128 bytes
label2:     .fill   128, 2, 1   @ reserves 128 2-byte blocks (256 bytes) 
                                @ with each 2-byte value equal to 1
```

[^1]: It's super important to note that with the ARM compiler, [the syntax is 
slightly different](https://www.keil.com/support/man/docs/armasm/armasm_dom1361290023271.htm). 
The order of the values is \# of blocks, value, size. When in doubt, you can also 
just use `.space` in either syntax and provide the number of bytes followed by the 
fill value you want. (e.g., `.space  128, 1` for 128 bytes set to the value 1) 