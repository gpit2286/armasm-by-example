@ Program 21: Bus Rider
@ https://www.armasm.com/docs/neon/bus-rider/
@
@ Write a program that uses matrix multiplication to solve: 
@   - Bus Trip: $3.00x + $3.20y = $183.80 
@   - Train Trip: $3.50x + $3.60y = $209.90
@
@   Registers: 
@       r4: children total 
@       r5: adult total 
@       d0: matrix containing the price totals 
@       d1: row 1 of inverse matrix 
@       d2: row 2 of inverse matrix 
@       d3: results 
.include "write.s" 

.global _start 

_start: 
    ldr             r0, =total      @ load address of total matrix 
    ldr             r1, =inv_col1   @ load address of inverse matrix 

    vld1.f32        {d0}, [r0]      @ load totals to NEON registers 
    vld1.f32        {d1-d2}, [r1]   @ load inv matrix to NEON registers 
                                    @ this could be done in one vdl1, but 
                                    @ broken into two for clarity. 

                                    @ [1  2] [a   b] 
                                    @        [c   d] 

    vmul.f32        d3, d1, d0[0]   @ multiplies 1a and 1b and stores in d3  

    vmla.f32        d3, d2, d0[1]   @ multiplies 2c and 2d and adds it to d3. 
                                    @ this results in r3  
                                    @ (1a + 2c) and (1b + 2d)
                                    @ and solves the matrix 
    
    @ convert to whole numbers as there 
    @ were no fractional people on the bus
    @ d3 can be addresses as s6 and s7 to get 
    @ individual 32-bit floats 
    vcvtr.u32.f32   s6, s6          @ convert d3[0] to integer and store in s6
                                    @ needs to be addressed as single reg
    vmov            r4, s6
    vcvtr.u32.f32   s7, s7          @ convert d3[1] to integer and store in s7
                                    @ again, vcvt needs to be addresses as so
    vmov            r5, s7

    @ setup itoa for children 
    mov             r0, r4
    ldr             r1, =buf 
    bl              itoa 

    @ display children
    nullwrite       child
    nullwrite       buf 

    @ write line ending 
    mov             r0, #0x000a       @ line ending 
    ldr             r1, =buf 
    strh            r0, [r1]        
    nullwrite       buf 

    @ setup itoa for adults 
    mov             r0, r5
    ldr             r1, =buf    
    bl              itoa

    @ display adults 
    nullwrite       adult 
    nullwrite       buf 
    
    @ write line ending 
    mov             r0, #0x000a       @ line ending 
    ldr             r1, =buf 
    strh            r0, [r1]        
    nullwrite       buf 

    @ exit program 
    mov             r7, #1          @ 1 = exit 
    mov             r0, #0          @ 0 = no error 
    svc             0 

.data 
total:      .single     183.8, 209.9 

inv_col1:   .single     -9.0, 8.75 
inv_col2:   .single     8.0, -7.5 
adult:      .asciz      "Adults: "
child:      .asciz      "Children: "
buf:        .fill       16 
