@ Program 12: Ok, Be Negative
@ https://www.armasm.com/docs/bit-operations/ok-be-negative/
@
@ I've realized that it's okay if more of my friends have negative happiness scores. 
@ I mean, I want them to be happy. But I want to make sure that they are surrounded 
@ by people who feel the same way as them. And actually I decided to include 
@ everyone on my Facebook account and increase the happiness score to a 2-byte number. 
@
@ In the list of numbers, count the number of consecutive pairs of numbers where 
@ the happiness score is either both positive or both negative. 
@
@ Example: 
@ Input: 2, 3, -2, -3, -4, 2 
@ Output: 2 -- (2, 3) and (-2, -3) would match the pattern 
@
.global _start 

_start: 
    @ your code here 

.data
innums:         .short      -25632, -26258, -14520, -17244, -27928, -10516, 22111	
    .short  20205, 7660, -22007, -29751, -24698, -21164, -15983, 14751, -5697	
    .short  -6785, -1659, 21635, -21710, -20321, -10728, -11844, 22352, -4139
    .short  14516, -1667, -12114, -11015, 31752, -9897, -31961, -24075, 16824	
    .short  7786, 14431, -9417, -18009, 30501, 2403, 13063, -6403, 24156, -15683
    .short  -29159, 12910, -10685, 301, 29618, 30915, -8759, 9606, -26819, 2806	
    .short  2066, 22329, -18162, -14837, -6507, -16448, -22480, 24554, 27946 
    .short  -6745, -9312, -21944, -7786, 2059, 23816, 16624, 25232, -23564	
    .short  -26684, 12668, -12642, -4890, -18335, 15913, 17194, 30886, 13991	
    .short  -1446, 23772, 8247, 17997, 11757, -2601, 13597, 17590, -13058
    .short  11048, -31765, -25765, -120, -9911, -6038, 2252, 5039, 13590, 12922
    .short  0
