---
title: "Program 18: Add the Inputs"
weight: 2
type: programs

description: |
   For this program, create a program that prompts the user to enter some numbers. 
   After each number, total the numbers entered by the user. When an empty line 
   is entered, display the total. 

   The numbers you should enter are: 
   - 6263
   - 8050
   - 7979
   - 7300
   - 6320   

source: https://github.com/gpit2286/armasm-by-example/tree/master/18-add-the-inputs
youtube_id: "" 
input: https://github.com/gpit2286/armasm-by-example/tree/master/18-add-the-inputs/template
output: "35912"
---

## Reading input and the docs 

As you dig in deeper and deeper into your programming journey, it becomes more and 
more important to be able to read the docs. As boring and monotonous as that sounds, 
this is the best way to learn. Start by looking at the 
[table of syscalls](https://syscalls.w3challs.com/?arch=arm_strong) that you saw 
before. You can see that read is #3. 

To learn more about the `read` operation, you can 
use the man pages by looking at the 2 (syscall) entry. In the terminal type: `man 2 read` 
This tells you everything you need to know about how to make this syscall and 
what variables it is expecting. 

As you read this man page, you can see that read takes three arguments. For this 
exercise, you will read from stdin. To give them to the supervisor, you will put 
them in r0, r1, and r2 -- very much in the same way you call write! 

1. int fd: 0 = stdin 
2. void *buf: The * tells you that is is expecting an address. So this is where the 
   output buffer space is in memory. Since the largest unsigned 32-bit number is 
   4,294,967,296, this needs to be 10. You can make this a null terminated area for 
   easier processing. (Just change the number of bytes to 11 as opposed to 10)
3. size_t count: This is the max number of characters you are willing to read. 
   Again, since the largest number is 10 digits, you only want to accept 10 digits. 

## Automatic length calculation 

Imagine you have a long string in the data section and you don't want to calculate 
the length. Or possible a string where the length may change. You can use the 
following form to automatically calculate the length on compile. The dot acts as 
representation of "this memory address here" and then you subtract the address 
at the given label. This results in the length: 

```armasm 
.data
prompt:     .asciz      "Input a number to add or Enter to sum:\n"
promptlen:  .word       .-prompt
```

## Another quick note about errors 

Again, I feel like I need to stress the absence of error checking in these examples. 
Especially when it comes to reading user input: *things will go wrong*. If the numbers 
added overflow, there is no check there. If the number entered is negative, there 
is no check there. If the input length is > 10, there isn't really a check there. 
Please, please, please, stand on the shoulders of those who came before you and 
always be aware of all the ways something can go wrong. This is more true in 
assembly than any other programming language. 
 