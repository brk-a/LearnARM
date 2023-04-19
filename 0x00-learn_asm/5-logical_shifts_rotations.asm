.global _start
_start:
    mov r0, #10
    lsl r0, #1
    lsr r0, #1
    mov r1, r0, lsl #1
    mov r2, r0, lsr #1
    mov r0, #15
    ror r0, #1
    mov r0, #15
    mov r1, r0, ror #1
    mov r2, r0, ror #31