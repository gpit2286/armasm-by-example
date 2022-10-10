@ Program 1:  Exiting
@ https://www.armasm.com/docs/getting-to-hello-world/exiting/
@
@ A simple ARM assembly program that exits gracefully 

.global _start

_start: 
  mov  r7, #1          @ Setup service call 1 (exit)
  mov  r0, #0          @ param 1 - 0 = normal exit
  svc  0