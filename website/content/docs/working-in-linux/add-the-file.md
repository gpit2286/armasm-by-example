---
title: "Program 19: Add the File"
weight: 3
type: programs

description: |
   There is a file named `numbers` in the template directory. Open this file 
   with your program and then read it line by line, creating a grand total of 
   all the numbers. After adding all the numbers, display the sum. 

source: https://github.com/gpit2286/armasm-by-example/tree/master/19-add-the-file
youtube_id: "" 
input: https://github.com/gpit2286/armasm-by-example/tree/master/19-add-the-file/template
output: "111740"
---
 
## Reading more of the docs

For the next exercise, you will use the read call again, but on an actual file 
and not stdin.  In the last example you knew the file descriptor was 0 for stdin. 
For this, you will need to first open the file in order to get the file descriptor. 

When you look at the man page for open (`man open 2`) you will the following note: 

> The argument flags must include one of the following access modes: O_RDONLY, 
> O_WRONLY, or O_RDWR. These  request  opening  the file read-only, write-only, 
> or read/write, respectively.

These are actually integers -- the flags listed are only the variable name. So your 
first step should be getting the correct integers for these constants. But where 
do you start looking? If you look under the synopsis section of the man page, it has the files 
that are included. One of those files must have the definitions. After you search  
those files 🙄 you will find the information you want in the `fcntl.h`. If you are 
using a Linux based OS, it should be available at: 
`/usr/include/asm-generic/fcntl.h`  Note that if you go and continue with a 
64-bit version of the processor/operating system, many of the calls are different 
than the 32-bit version of the calls. Everything in this set of exercises works with the 32-bit calls.
 
After all of this searching, you only need to open the file for read only which 
is actually equal to 0. This may be the first time of many for some of you where 
a long trail of bread crumbs leads to the number zero. Life's just like that sometimes. 
