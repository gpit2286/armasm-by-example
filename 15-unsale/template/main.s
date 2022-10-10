@ Program 15: The Un-sale
@ https://www.armasm.com/docs/bit-operations/unsale/
@
@ The shop I own (I don’t) had a sale but some employee decided to not write 
@ down the original price of all of the items! Well, it’s simple because all of 
@ the prices are 1/3 of their original amounts. The problem is I have a billion 
@ prices so I need to figure out how to get the original price as quickly as 
@ possible!!! Take the list of prices and output the original price. No need to 
@ output the discounted price. This will be used a called function in bigger program.
@
.global _start 

_start: 
    @ Your code here 

.data 
input:      .word   911, 869, 566, 958, 787, 0
output:     .fill   11
