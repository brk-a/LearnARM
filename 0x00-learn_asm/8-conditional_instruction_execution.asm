.global _start
_start:
    mov r0, #2
    mov r1, #4
    cmp r0, r1

    addlt r2, #1
    movge r2, #2
    subeq r2, #3
    