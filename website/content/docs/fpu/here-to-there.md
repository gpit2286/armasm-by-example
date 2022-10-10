---
title: "Program 20: Here to There"
weight: 2
type: programs

description: |
    **Note**: What I really really really wanted to do here was have you write a float to 
    ASCII implementation. As there are multiple papers written on the subject and it's 
    quite complex, I wanted to find another exercise that would allow you to interact 
    with a floating point number.  If you have a better exercise for this, please let 
    me know. 

    For this exercise, you are given two points. Find the distance between the two 
    points and then output the parts of the equation. If the the below bit 
    representation was the result: 

    | Sign (+/-) | Exponent | Fraction | 
    |:----------:|:--------:|:--------:|
    | 0    | 11110011 | 11100000000000000000000 | 
    | +     | 243 | 1/2 + 1/4 + 1/8 | 

    You would output:

    ```
    Sign: + 
    Exponent: 116
    Fraction (1/x): 1 2 4 8
    ```
    Input Points: (4, 5), (2, 1)

source: https://github.com/gpit2286/armasm-by-example/tree/master/20-here-to-there
youtube_id: "" 
input: https://github.com/gpit2286/armasm-by-example/tree/master/20-here-to-there/template
output: |
    Sign: +
    Exponent: 2
    Fraction (1/x): 1 16 32 64 128 \
    2048 4096 16384 32768 65536 262144 \
    524288 1048576 2097152 8388608
---

 
## Floating point numbers 

How does a floating point number actually work? IEEE 754 is the tech sheet that 
talks about floating point numbers. For single precision, it says that the layout 
is: 

| Sign (+/-) | Exponent | Fraction | 
|:----------:|:--------:|:--------:|
| bit 31     | bits 23-30 | bit 0-22 | 

For double precision it is: 

| Sign (+/-) | Exponent | Fraction | 
|:----------:|:--------:|:--------:|
| bit 63     | bits 52-62 | bit 0-51 | 


The sign bit is the easy part. If the bit is 1, it is negative and if it's 0 the 
number is positive. 

The next set of bits are the exponent for the number 2. 
When representing the exponent, the number here will never be read as negative. 
Instead, the exponent is read as a positive 
and a bias is removed. (127 for single and 1023 for double) So if, in a single 
precision float, the exponent is written as 129, the exponent is really 2. (129-127)

The fraction or mantissa is represented as 1 (not encoded) plus the addition 
of 2^-x where x is the 1-indexed bit from the most significant side. 
If the fraction started with `101011`... it would represent. 

{{< katex display >}}
1 + 2^{-1} + 2^{-3} + 2^{-5} + 2^{-6} ... 
\\
\text{or} 
\\
1 + \frac{1}{2} + \frac{1}{8} + \frac{1}{32} + \frac{1}{64} ... 
{{< /katex >}}

If you really want to dig into this conversion, [this website](http://class.ece.iastate.edu/arun/Cpre305/ieee754/ie4.html) is one of the most clear and concise explanations I've found. 


