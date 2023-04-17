.global _start
_start:
    mov r0, #5
    mov r1, #7
    add r2, r0, r1 ;r2 = r0 + r1
    sub r3, r0, r1
    mul r4, r0, r1
    subs r5, r0, r1
    adds r6, r0, r1
    adc r2, r1, r0 ; r2 = r0 + r1 + carry