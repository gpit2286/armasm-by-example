---
title: "Program 17: Add the Arguments"
weight: 1
type: programs

description: |
    The next couple of exercises are all going to be doing the same thing. Reading 
    inputs, adding them together, and then outputting the result. For this, you will 
    first need to create an ASCII to integer function. (Unsigned integer is fine) 
    Create this in an outside file so you can reuse it.  

    For this example, use the below command to invoke your program and output the 
    sum of the arguments. 

    ```bash 
    ./main 33 56 76 45 34 23 54 87 56 334 7556 34332 5643 646 234 64
    ```

source: https://github.com/gpit2286/armasm-by-example/tree/master/17-add-the-arguments
youtube_id: "yYi2Bs-iAHU" 
input: https://github.com/gpit2286/armasm-by-example/tree/master/17-add-the-arguments/template
output: "49273"
---
 
## Reading program arguments 

The first type of interaction you will learn about is how arguments are passed to 
a program from the Linux command line.  To understand/visualize this, I HIGHLY 
recommend installing an extension such as [GEF](https://gef.readthedocs.io/en/master/) 
for the GNU debugger. 

Take one of the programs you have created and start it in GDB.  When you do this, 
set a break point at `_start` and run it using the command: `r arg1 arg2 arg3`. 
This will start the program running, pause on the first line and pass three arguments 
to the program. 

If you're using an extension, you should easily see the stack. 

![Stack Visualization](/img/stack-vis.png)

The first address (0x7efffc60) has the value of 0x4. This is the number of arguments 
passed into the program from the command line.  You will also notice the $sp label, 
which refers to which address the stack pointer is pointing to. 

The first argument passed in is always the path of the program running. In this 
example, the value stored at address 0x7efffc64 is the starting address of the **null 
terminated ASCII string**. Also note that the argument list is null terminated. 
(Address 0x7efffc74) Every other argument is the same. The value stored on 
the stack is the address of where the value is in memory. It is important to also 
remember that all of these will be passed in as they are typed. (i.e., ASCII and 
not integers) You CAN use escape codes or pipe in information from another program, 
but when calling from the CLI, you're almost always going to be working with arguments 
in ASCII. 
