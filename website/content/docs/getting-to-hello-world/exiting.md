---
title: "Program 1: Exiting"
weight: 2
type: programs

description: >
    Write a program that exits with the error code 0. 
source: https://github.com/gpit2286/armasm-by-example/tree/master/01-exiting
youtube_id: "qX6NoqkAMGU" 
# input: https://link to resource 
output: | 
    armasm:~$ ./main 
    armasm:~$ echo $?
    0
---


While you may wonder why you need to talk about how to exit a program, know that you do. Unlike 
many higher languages, assembly programs don't gracefully exit when you stop writing code. 
What happens if you don't exit the program is the the computer will keep reading data 
in memory past the last opcode. Because you are running in a *nix environment, you will 
get a segmentation fault as it will drift into memory you don't have access to. If 
this were an embedded solution (with no operating system), it is the definition of 
unexpected behavior. 

## MOV operation 

The first operation you are going to use is `mov`. `mov` **moves** a value into 
a register. It can move an immediate value or a value stored in another register. 

```armasm 
    mov     r0, #2          @ moves the value 2 into register 0 
    mov     r1, r0          @ copies the value 2 from register 0 to register 1 
                            @ register 0 is still equal to 2
```

## Supervisor Calls

Supervisor calls or system calls (syscalls) are the way that our program communicates
with the operating system (known as the supervisor).  There is a 
[whole list](https://syscalls.w3challs.com/?arch=arm_strong) of calls that you 
can make ranging from opening files, to forking processes, to exiting programs. 

There are two ways you can make supervisor calls in ARM assembly, but we will only 
be using this format: 

- Supervisor call number loaded into r7 (without the 0x900000 prefix)
- Parameters generally loaded into r0-r3
- Supervisor call executed with the command `svc    0` 

### Reading the syscall table 

Take a second and go to the link labeled as whole list. You can see the name is 
the name of the function. For this first example, you need exit. As you can see it's 
close to the top. If you read across the table, you can see the next column is 
labeled as r7. This is the number you need to put into register 7, but without the 
0x900000 prefix. (i.e., 1) The next couple of columns are the parameters that will 
be passed to the function, conveniently labeled r0-r5. For the exit call, you only 
need one parameter put into r0, which is the `int error_code`.

### A Note about data types 

The exit call expects an integer. You will see that when you use this, you 
can't tell the computer that you are using 
and integer, but only put a number into the register. The types that are listed in 
this table, for the assembly programs you will be writing, should be approached 
as "this the the type the kernel will interpret the value as." While it may not 
effect us too much in this course, consider this. 

Imagine you are calling the read 
command and the file descriptor is 4,294,967,259. (Not practical but suspend 
disbelief.) Because the read call expects an unsigned integer, this would be fine. 
Now imagine that there was some crazy error and you wanted to pass the file descriptor 
as the error code on the exit call to debug. Since the exit call is NOT unsigned, 
it would actually output -37 because the exit call *can* be negative. We'll talk 
more about this later, but just keep this in the back of your head when you are 
reading the table and interpreting the data types.  

## Compiling and Running 

To compile the program, you actually need to run two commands. If the filename is 
main.s, the first command you need to run is: 

```bash
as -o main.o main.s
```

This will invoke the assembler and take all of the code we wrote and convert it 
into the 1's and 0's that the processor will understand. The next thing you need 
to do it run the linker with: 

```bash
ld -o main main.o
```

This will take the raw code and organize it in the way the operating system and 
processor expects it to be in. You can then finally run: 

```bash 
./main
```

and get the result. 

