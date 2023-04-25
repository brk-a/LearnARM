.equ SWITCH, 0xff200040
.equ LED, 0xff200000

.global _start
_start:
    ldr r0, =SWITCH
    ldr r1, [r0]
    
    ldr r0, =LED
    str r1, [r0]