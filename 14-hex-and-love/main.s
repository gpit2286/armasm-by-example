@ Program 14: Hex and Love
@ https://www.armasm.com/docs/bit-operations/hex-and-love/
@
@ I have a bunch of colors saved from my web programing and I would like to 
@ take those rgb values and convert them to #rrggbb values. Write a program 
@ that takes sets of three rgb values and converts them into the #rrggbb hex 
@ representation.
@ 
@ Note: The red color will never be 0.
@
@   Registers:     
@       r4: input address 
@       r5: output address 
@       r6: hexstr 
@       r7: reserved for syscalls 
@       r8: current byte 
@       r9: byte half 
@       r10: hexletter 
@       r11: inner loop counter 
.global _start 

_start: 
    ldr     r4, =input      @ load input ints
    ldr     r6, =hexstr     @ load hexstr address 
    ldrb    r8, [r4], #1    @ load first number 
loop:
    cmp     r8, #0          @ see if we have null 
    beq     exit
    ldr     r5, =outstr     @ reset out address
    mov     r11, #0         @ reset inner loop counter 
inner: 
    cmp     r11, #3         @ check to see if we read 3 sets 
    bge     inexit 

                            @   The order looks backwards because of the endiness 
                            @   The first hex should be D4E4BC 
                            @   In memory, it should be backwards: D4E4BC
                            @   So when we take the number and convert it to ASCII, 
                            @   The higher half needs to be written first 
    @ Load first letter
    and     r9, r8, #0xf0   @ mask off the 7-4 bits 
    lsr     r9, #4          @ move to least significant bits 
    ldrb    r10, [r6, r9]   @ load hexstr + offset to get letter 
    strb    r10, [r5], #1   @ str hex letter and increment 
    @ Load second letter 
    and     r9, r8, #0xf    @ mask off bits 3-0
    ldrb    r10, [r6, r9]   @ load hexstr + offset to get letter 
    strb    r10, [r5], #1   @ str hexstr and increment
    ldrb    r8, [r4], #1    @ load next int to convert
    add     r6, #1          @ increment counter 
    b       inner 
inexit: 
    mov     r10, #'\n'      @ load line ending 
    strb    r10, [r5]       @ store line ending 
    
    @ setup write 
    mov     r7, #4          @ 4 = write 
    mov     r0, #1          @ 1 = stdout 
    ldr     r1, =outstr     @ load outstr address 
    mov     r2, #7          @ 7 = length (6 hex + line ending) 
    svc     0 

    b       loop 
exit: 
    @ setup exit 
    mov     r7, #1          @ 1 = exit 
    mov     r0, #0          @ 0 = no error 
    svc     0

.data 
hexstr:     .ascii      "0123456789ABCDEF"
input:      .byte       212, 228, 188
            .byte       150, 172, 183
            .byte       54, 85, 143
            .byte       64, 55, 110
            .byte       72, 35, 60
            .byte       0   
outstr:     .fill       7
