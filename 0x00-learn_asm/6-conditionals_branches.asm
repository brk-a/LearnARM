.global _start
_start:
    mov r0, #1
    mov r1, #2
    cmp r0, r1
    bal default
    bgt greater
    bge greater_equal
    blt lesser
    ble lesser_equal
    beq equal
    bne not_equal

default:
    mov r2, #0

greater:
    mov r2, #1

greater_equal:
    mov r2, #2

lesser:
    mov r2, #3

lesser_equal:
    mov r2, #4

equal:
    mov r2, #5

not_equal:
    mov r2, #6