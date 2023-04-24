.global _start
_start:
    mov r0, #1
    mov r1, #3
    push {r0, r1}
    bl get_value
    pop {r0, r1}
    b end


get_value:
    mov r0, #5
    mov r1, #9
    add r2, r0, r1
    bx lr

end:
    