# Logical shifts and rotations
refer to [`5-logical_shifts_rotations.asm`](./5-logical_shifts_rotations.asm)

### the code
* `.global _start`--> inform system(s)/people that there is a `_start` label ahead 
* `_start:`--> the entry point; code under the label begins to execute here
*  `   mov r0, #10` --> store decimal 10 in `r0`
*  `   lsl r0, #1` --> perform a left shift once on the contents of `r0` and store the result in `r0`
*  `   lsr r0, #1` --> perform a right shift once on the contents of `r0` and store the result in `r0`
*  `   mov r1, r0, lsl #1` --> store the contents of `r0` in `r1` then perform a left shift once on the contents of `r1` \[store the result in `r1`, of course\]
*  `   mov r2, r0, lsr #1` --> store the contents of `r0` in `r2` then perform a right shift once on the contents of `r2` \[store the result in `r2`, of course\]
*  `   mov r0, #15` --> store decimal 15 in `r0`
*  `   ror r0, #1` --> perform a rotation to the right once on the contents of `r0` and store the result in `r0`
*  `   mov r0, #15` --> store decimal 15 in `r0`
*  `   mov r1, r0, ror #1` --> store the contents of `r0` in `r1` then perform a rotation to the right once on the contents of `r1` \[store the result in `r1`, of course\]
*  `   mov r2, r0, ror #31` --> store the contents of `r0` in `r2` then perform a rotation to the right 31 (or 32 less 1) times on the contents of `r2` \[store the result in `r2`, of course\]. rotation to the left `rol` does not exist in ARM; the equivalent, therefore, is to rotate to the right 32 less _n_ times (64 less _n_ for a 64-bit word). _n_ is the number of times to rotate to the left

### notes
* logical shifts and rotations allow the user to manipulate data at the bit level
* look at this from a bit perspective, not an octal, decimal or hexadecimal one
* two ways to do logical shifts:
    * logical shift to the left `lsl` --> move bits one position to the left of the starting position
        * e.g. binary 10 (or 0b00001010) shifted left becomes binary 20 (or 0b00010100)
        * notice how the rightmost four bits in binary 10 are now the second, third, fourth and fifth rightmost bits in binary 20
        * notice how shifting binary 10 to the left results in binary 20 (20 equals 10 times 2); this is not a coincidence
        * shifting to the left once is, simply, multiplying by two
    * logical shift to the right `lsr`  --> move bits one position to the right of the starting position
        * e.g. binary 10 (or 0b00001010) shifted right becomes binary 5 (or 0b00000101)
        * notice how the second, third and fourth rightmost in binary 10 are now the three  rightmost bits in binary 5 (the rightmost zero is, simply, discarded)
        * notice how shifting binary 10 to the right results in binary 5 (5 equals 10 divide by 2); this is not a coincidence
        * shifting to the right once is, simply, dividing by two
* two ways to do rotations:
    * rotation to the right `ror ` --> rightmost bit is made the leftmost during a right shift
        * e.g. perform a rotation on binary 5 (or 0b00000101); result is 0b10000010
            * notice how the rightmost bit, 1, in binary 5 is the leftmost bit in the result
            * 0b10000010 is either a large, positive number (decimal 130) or a negative number (decimal -2) depending on the most significant bit (MSB)
        * rotations are useful for: hashing, crypto, graphics etc
    * rotation to the left `rol` --> leftmost bit is made the rightmost during a left shift. ARM does not have `rol`. Repeat: `rol` does not exist in ARM
        * why?
            * `ror` exists
            * not used by many systems, if at all
        * can one perform a rotation to the left without `rol`?
            * yes. say you want to rotate a bit n times to the left. perform a rotation to the right 32 less n times (64 less n for a 64-bit word)
* it is possible to shift and/or rotate by a variable number of times
    * e.g.
    ~~~asm
    mov r0, #10
    mov r1, #2
    mov r2, r0, lsl r1
    mov r3, r0, lsr r1
    mov r4, r0, ror r1
    mov r5, #32
    sub r1, r5, r1
    mov r6, r0, ror r1
    ~~~
    notice how all shifts and rotations are done _contents-of-`r1`_ times. `r1` can hold any number
    * from the example above: result of `lsr` is 2, not 2.5 (10 divided by 4 is 2.5 not 2). why?
