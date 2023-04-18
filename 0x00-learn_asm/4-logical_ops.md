# Logical Operations
refer to `4-logical_ops.asm`

### the code
* `.global _start` --> inform system(s)/people that there is a `_start` label ahead 
* `_start:` --> the entry point; code under the label begins to execute here
*    `mov r0, #0xff` --> store hex 255 in `r0`
*    `mov r1, #22` --> store decimal 22 in `r1`
*    `and r2, r0, r1` --> perform bitwise `AND` on the contents of `r0` and `r1` then store the result in `r2`
*    `ands r3, r0, r1` --> perform bitwise `AND` on the contents of `r0` and `r1` then store the result in `r3` and turn on the `` flag inside the `cpsr`
*    `orr r4, r0, r1` --> perform bitwise `OR` on the contents of `r0` and `r1` then store the result in `r4`
*    `orrs r5, r0, r1` --> perform bitwise `OR` on the contents of `r0` and `r1` then store the result in `r5` and turn on the `` flag inside the `cpsr`
*    `eor r6, r0, r1` --> perform bitwise `XOR` on the contents of `r0` and `r1` then store the result in `r6`
*    `eors r2, r0, r1` --> perform bitwise `XOR` on the contents of `r0` and `r1` then store the result in `r2` and turn on the `` flag inside the `cpsr`
*    `mvn r0, r0` --> perform bitwise _`negation`_ on the contents of `r0` then store the result in `r0`
*    `and r0, r0, #0x000000ff` --> perform bitwise `AND` on the contents of `r0` and hex 255 then store the result in `r0`

### notes
* basic logic ops: `AND`, `OR`, `XOR`, _`negation`_ etc used for bitwise ops
* op codes `and`, `orr` (double"r"), and `eor` (not `xor`) perform bitwise `AND`, `OR` and `XOR` respectively
* op codes `ands`, `orrs`, and `eors` do as `and`, `or` and `eor` respectivley work; they also set various flags in the `cpsr`
* op code `mvn` (move negative) negates the contents of a source/target register then moves the result to a destination register. negates the _whole_ register. example: `mvn r0, r0` says perform bitwise _`negation`_ on the contents of `r0` then store the result in `r0`. say that `r0` has the value hex 255 (which, in the register, will be 0x000000ff). the result of the operation is the value 0xffffff00 stored in `r0` (notice how 0x000000ff is changed into 0xffffff00)
    * question: can one avoid negating the whole register?
        * yes. reset the register 
    * how?
        * QED: use `and`. pass an argument that always evaluates to zero
        ~~~asm
        mov r0, #0xff
        mvn r0, r0
        and r0, r0, #0x000000ff
        ~~~
        the last operation `and r0, r0, #0x000000ff` clears the leftmost six bytes because _and_-ing anything with zero evaluates to zero and _and_-ing anything with `f` evaluates to whatever the anything is 
