.global _start
_start:
    mov r0, #0xff
    mov r1, #22
    and r2, r0, r1
    ands r3, r0, r1
    orr r4, r0, r1
    orrs r5, r0, r1
    eor r6, r0, r1
    eors r2, r0, r1
    mvn r0, r0
    and r0, r0, #0x000000ff