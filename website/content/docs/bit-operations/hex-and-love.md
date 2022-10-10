---
title: "Program 14: Hex and Love"
weight: 7
type: programs

description: |
    I have a bunch of colors saved from my web programing and I would like to take 
    those rgb values and convert them to #rrggbb values. Write a program that takes 
    sets of three rgb values and converts them into the #rrggbb hex representation. 

    A test set of values in included in the template. 

    * Note: The red color will never be 0. 

source: https://github.com/gpit2286/armasm-by-example/tree/master/14-hex-and-love
youtube_id: "CIraHiRy1yY" 
input: https://github.com/gpit2286/armasm-by-example/tree/master/14-hex-and-love/template
output: |
    D4E4BC
    96ACB7
    36558F
    40376E
    48233C
---
 
## Converting decimal to hexadecimal 

You know that you can enter numbers as decimal, octal, binary, or hexadecimal. 
The question is, however, how do you actually change base? Going from binary 
(base 2) to hexadecimal (base 16) is fairly easy because 2 fits inside of 16. When 
you go from decimal (base 10) to hexadecimal, you need to get to that intermediate 
step. 

Take the number 200. To visualize the base change better, write 200 in binary. From 
there you can see that 200 fits inside 1 byte. Within that byte, you can break it 
into two 4-bit slices. These two 4-bit slices are then converted to 0-F to get 
the hexadecimal representation. 

```text 
    Decimal: 200 
    Binary: 11001000 
        Group1: 1100 = 12 => c 
        Group2: 1000 = 8 => 8
    Hexadecimal: c8 
```
