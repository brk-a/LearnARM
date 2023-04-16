.global _start
_start:
    ldr r0,=list
    ldr r1,[r0]
    ldr r2,[r0,#4]
    ldr r3,[r0,#4]!
    ldr r4,[r0],#4

.data
list:
    .word 4,5,-9,1,0,2,-7