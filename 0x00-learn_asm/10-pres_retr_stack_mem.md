# Preserving and retrieving data from stack memory
refer to [10-pres_retr_stack_mem.asm](./10-pres_retr_stack_mem.asm)

### the code
* `.global _start` --> inform system(s)/people that there is a `_start` label ahead
* `_start:` --> the entry point; code under the label begins to execute here
* `   mov r0, #1` --> store decimal 1 in `r0`
* `   mov r1, #3` --> store decimal 3 in `r1`
* `   push {r0, r1}` --> store the contents of `r0` and `r1` in stack mem and store the address of the first one in the register `sp`
* `   bl get_value` --> store the address of the next instruction (`pop`) in register `lr` and branch to label `get_value`
* `   pop {r0, r1}` --> store the contents previously pushed to stack mem, starting at the address in  `sp`, in `r0` and `r1`
* `   b end` --> branch to the label `end`. op code `b` is _`b`ranch to_

* `get_value:` --> label `get_value`. code under the label executes when `bl get_value` executes
* `   mov r0, #5` --> store decimal 5 in `r0`
* `   mov r1, #9` --> store decimal 9 in `r1`
* `   add r2, r0, r1` --> store the sum of the contents of `r0` and `r1` in `r2`
* `   bx lr` --> branch to the instruction at the address contained in register `lr`

* `end:` --> label _end_. code under label executes when `b end` executes
*      --> no code under `end`, therefore, nothing happens. programme terminates because there are no instructions


### notes
* the number of registers in a machine are finite
* what happens when the system runs out of registers?
    * it re-uses registers
* what if there are values already in said registers?
    * the values are _persisted_ (or _preserved_, whichever you like)
    * consider the scenario where a function call is made and said function uses registers that have values already: 
    ~~~asm
    mov r0, #1
    mov r1, #3
    bl get_value

    get_value:
        mov r0, #5
        mov r1, #9
        add r2, r0, r1
        bx lr
    ~~~ 
the values `1` and `3` in `r0` and `r1` respectively are overwritten by `5` and `9` when `get_value` is called
* the system must have a way to _remember_ `1` and `3` so that they can be restored when the function returns. here is how: it pushes `1` and `3` into stack memory, calls the function, function returns and system pops `1` and `3` from stack memory. the scenario above would be viz:
    ~~~asm
    mov r0, #1
    mov r1, #3
    push {r0, r1}
    bl get_value
    pop{r0, r1}

    get_value:
        mov r0, #5
        mov r1, #9
        add r2, r0, r1
        bx lr
    ~~~ 
the values `1` and `3` in `r0` and `r1` respectively are pushed to stack memory. `get_value` is called, therefore, `r0` and `r1` get the values `5` and `9`. they get their initial values once  `get_value` returns. this is how values `1` and `3` anre _persisted_
    * notice how register `sp`, containing the stack pointer, behaves during the `push` and `pop` operations
    * notice how register `pc`, containing the address of the next instruction/operation after `bl`, behaves when `bl` and `bx` execute 
* this is the simple "traditional" way of implementing scope (global, local) and handling return values; the advanced way places the value(s) in an unused register(s) (which cannot be determined in advance in real life)
* 