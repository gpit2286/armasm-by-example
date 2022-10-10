---
title: "Program 7: Cloning Myself"
weight: 6
type: programs

description: >
    Having lived through quarantine, I have decided that I would like the last year 
    or so of my life back. In order to do this, I am going to clone myself and then 
    transfer my brain into a new body. However, since replication errors are a thing, 
    write a program that will show the expected pairs so I can double check.

    In DNA strings, symbols "A" and "T" are complements of each other, as "C" and "G". 
    The input is already entered for you in the template. 
source: https://github.com/gpit2286/armasm-by-example/tree/master/07-cloning-myself
youtube_id: "DA2fPYd83MQ" 
input: https://github.com/gpit2286/armasm-by-example/tree/master/07-cloning-myself/template
output: |
    CATAGCTAGCTAGCTAGCTAATATAAAAG
    CTGCTCTAAATTTATATATATATATGCTC
    TCTTATGTCTATCTGTCTAAT
---

 
## Make files 
In the current day of project builders, scaffolding, runners, and so forth one 
may forget that there was a time, not so long ago, that you could just use a program 
installed on almost every *nix operating system. That program is `make`. 

The syntax for a make file is very simple. 

```make 
target: prerequisites
<TAB>steps to build
``` 

The first part is defining which files you need for the program. For the basic single 
file that you have been using, you only need one fine: main.o. Then you need to tell 
make how to create the main.o file. 

```make
main: main.o 
    ld -o main main.o 

main.o: main.s 
    as -o main.o main.s 
``` 

Soon, however, you will be writing programs with more than one object file. In order to 
create a base make file that can easily be edited, you need to adapt it slightly. 

```make 
# Define the object files you need for the final executable 
OBJS = main.o 

# The next line uses % which is a wildcard character to refer to all .s and .o files 
%.o : %.s 
    # $< = source file, $@ = output file 
    as $< -o $@ 

# build the main executable 
main: $(OBJS)
    ld -o main $(OBJS)
```

