@ Program 2:  Hello World
@ https://www.armasm.com/docs/getting-to-hello-world/hello-world/
@
@ A program that prints "Hello World!"

.global _start

_start: 
    mov  r7, #1          @ Setup service call 1 (exit)
    mov  r0, #0          @ param 1 - 0 = normal exit
    svc  0               @ ask linux to terminate us
