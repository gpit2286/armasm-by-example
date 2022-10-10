---
title: "Program 16: 64-bit Math"
weight: 9
type: programs

description: |
    Multiply two 32-bit numbers. Take the result and write an integer to ASCII 
    program that reads 64 bit numbers using this shift/long division method. 

    The two 32-bit numbers are `0xbf85be21` and `0xce0a6a80` and are already in 
    the template. 

source: https://github.com/gpit2286/armasm-by-example/tree/master/16-64-bit-math
youtube_id: "dPyS9dt4XxQ" 
input: https://github.com/gpit2286/armasm-by-example/tree/master/16-64-bit-math/template
output: "11107400488765799040"
---


## Binary long division 

If you remember back in middle school (elementary?), long division was one of 
those things where you probably just though, "can't I use a calculator?" Can you 
do this with other bases other than 10? Absolutely. Welcome to long division, 
binary edition. 

It's actually pretty simple. Look at an example of 200/8. 

```text
         00011001 = 25
        __________
  1000 | 11001000
1:       1 
2:       11
3:       110 
4:       1100
        -1000
         0100
5:        1001
         -1000
          0001
6:           10
7:           100
8:           1000
            -1000
```

As opposed to re-inventing the wheel, Ben Eater has a great detailed video 
explaining how to do this with a computer. [Video](https://youtu.be/v3-a-zqKfgA?t=573)

