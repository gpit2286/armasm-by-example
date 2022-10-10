---
title: Errors and Tests
weight: 1
---

# Errors and Tests 

{{< hint info >}}
Both of these topics are important and not explicitly covered in this tutorial. 
However, the sooner you start thinking about them, the better off you will be 
when you need/want to include them in your program. They are not presented here 
to give answers, only to make sure you are considering them. 
{{< /hint >}}

## Error handling 

One of the two things that you miss in this series of exercises is error handling. 
The Linux kernel allows you to specify exit codes when we exit a program. In the regard, it 
is easy for you to keep a table of possible errors and encode those exit numbers 
inside of your program.  After that, you start entering the rabbit hole of what other information do you want 
to give? 

Pretend you wrote a program that takes two arguments at runtime. The first argument 
should be a number and the second argument should be a string. If that first argument 
isn't a number you could: 

- do nothing and the program panics (crashes)
- just exit the program with a specific error code 
- exit the program with an error code, but call an error routine that will print 
  out a message saying what the error was 

Assume that the number is a number. Is it in range? Can your program handle the number 
if it's zero? There are all kinds of problems that can arise, and they need to be 
planned for eventually. These considerations become even more prevalent if you're 
writing a program for an embedded system. Do you blink an LED? Make a buzzer sound? 
How do you differentiate that LED blink or buzzer sound from one error to another?  

Every programming language has generally come up with some system of error handling. 
But when the language itself doesn't, you need to be very mindful as well as 
deciding how to mitigate those errors when they do occur. 

## Testing assembly 

The other part that is not addresses in this set of exercises but should be mentioned 
is testing your code. As your program gets bigger and bigger and includes more and more 
subroutines, testing becomes more important. 

The main premise of a testing suite is that you have a test runner that runs a series 
of mini-programs that assert that shared functions come back with expected results. 
There is also end-to-end testing that makes sure that the whole program works 
together in "real world" situations. 

As you might have guessed, there isn't really a "test suite" that is made to work with 
assembly out of the box. There are generic test runners, such as [BATS](https://github.com/sstephenson/bats), 
where you can create a separate test program, build them automatically with a make file, 
and then test them.  

### Testing setup example 

- You create a function that adds 2 to a number and returns the result 
- You import that function into a file that only has test cases 
- If the test result doesn't match the expected result, send error code xxx where 
  xxx is defined in the test file
- Run the test file in a test runner. If it exits with no error, then all the 
  tests passes. If there was an error, use the test file, the returned error code, 
  and a debugging program like GDB to find what went wrong and fix it 




