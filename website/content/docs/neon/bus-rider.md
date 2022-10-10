---
title: "Program 21: Bus Rider"
weight: 2
type: programs

description: |
   Using the same method, write a program 
   to solve for the following equations. The bus and train prices won't change, 
   so you can use the same inverse matrix. 

   - Bus Trip: $3.00x + $3.20y = $183.80 
   - Train Trip: $3.50x + $3.60y = $209.90

source: https://github.com/gpit2286/armasm-by-example/tree/master/21-bus-rider
youtube_id: "" 
input: https://github.com/gpit2286/armasm-by-example/tree/master/21-bus-rider/template
output: |
   Children: 25
   Adults: 34 
---
 
This is, without a doubt, a simple introductory program to use the NEON co-processor. 
It has all kinds of uses but I wanted to find something that was both simple 
and more concrete then "LOOK HOW COOL IT IS WHEN WE USE RANDOM NUMBERS TO DO 
RAY TRACING!!" A little backgrounds on matrices first if you don't know how they 
can be solved. 

## Matrices 

If you think back to linear algebra, you will probably remember a small part 
where you were working with matrices. I know when I was in math, it wasn't 
presented in a way that made it practical. They look something like this (I hope 
this doesn't give you bad flashbacks): 

{{< katex display >}}
\begin{bmatrix}
   1 & 2 \\
   3 & 4
\end{bmatrix}
{{< /katex >}}

### Multiplying matrices 

If you have two matrices and want to multiply them, this is the formula. Multiply 
each member of the the first matrix's row by every member of the second matrix's 
corresponding column and add them. I will not go into all of the questions like 
"why? how? magic? wtf?" here. 

{{< katex display >}}
\begin{bmatrix}
   1 & 10 & 100
\end{bmatrix}
\begin{bmatrix}
   1 & 2 \\ 
   3 & 4 \\ 
   5 & 6 \\ 
\end{bmatrix}
= 
\begin{bmatrix}
  531 & 642
\end{bmatrix}
{{< /katex >}}


{{< katex display >}}
531 = (1\times1) + (10\times3) + (100\times5) \\
642 = (1\times2) + (10\times4) + (100\times6)
{{< /katex >}}

### Inverse matrices 

The cool thing about matrices is that the concept of division is absent. There is 
only multiplication of the inverse. This is similar to how {{< katex >}}
6^1 \times 6^{-1} = \frac{6}{1} \times \frac{1}{6} = 1
{{< /katex >}}

## Matrices IRL

From the information above, you can then solve series of linear equations. Again, 
without getting into the details too much, look at this problem graciously borrowed 
from [mathisfun.com](https://www.mathsisfun.com/algebra/matrix-inverse.html). 

> A group took a trip on a bus, at $3 per child and $3.20 per adult for a total of $118.40.
> They took the train back at $3.50 per child and $3.60 per adult for a total of $135.20.
> How many children, and how many adults? 

In this equation there are two constants. The number of children (x) and the number 
of adults (y). You could write this as two equations. 

{{< katex display >}}
\text{Bus Trip:} \quad\$3.00x + \$3.20y = \$118.40 \\[2pt]
\text{Train Trip:} \quad\$3.50x + \$3.60y = \$135.20 
{{< /katex >}}

You may be able to see now how this would translate to a set of multiplied matrices. 

{{< katex display >}}

\begin{bmatrix}
   x & y
\end{bmatrix}
\begin{bmatrix}
   3 & 3.5 \\ 
   3.2 & 3.6 
\end{bmatrix}
= 
\begin{bmatrix}
   118.4 & 135.2 
\end{bmatrix}
{{< /katex >}}

From here, you can multiply the result by the inverse of the known matrix and 
get the unknown. Getting the inverse is a little complicated and out of the scope 
of this simple example, but trust me that this is correct. 

{{< katex display >}}
\begin{bmatrix}
   118.4 & 135.2    
\end{bmatrix}
\begin{bmatrix}
   -9 & 8.75 \\ 
   8 & -7.5 
\end{bmatrix}
= 
\begin{bmatrix}
   16 & 22
\end{bmatrix}
{{< /katex >}}

So there were 16 children and 22 adults. 

