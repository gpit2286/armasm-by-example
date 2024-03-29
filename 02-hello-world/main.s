@ Program 2:  Hello World
@ https://www.armasm.com/docs/getting-to-hello-world/hello-world/
@
@ A program that prints "Hello World!"

.global _start

_start: 
    mov  r7, #4          @ Setup service call 4 (write)
    mov  r0, #1          @ param 1 - File descriptor 1 = stdout
    ldr  r1, =hello      @ param 2 - address of string to print
    mov  r2, #13         @ param 3 - length of hello world string
    svc  0               @ ask linux to write to stdout

    mov  r7, #1          @ Setup service call 1 (exit)
    mov  r0, #0          @ param 1 - 0 = normal exit
    svc  0               @ ask linux to terminate us

.data
hello:    .ascii    "Hello World!\n"

