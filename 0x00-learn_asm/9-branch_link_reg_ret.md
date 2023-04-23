# Branch with link register and returns
refer to [9-branch_link_reg_ret.asm](./9-branch_link_reg_ret.asm)

### the code
* `.global _start` --> inform system(s)/people that there is a `_start` label ahead
* `_start:` --> the entry point; code under the label begins to execute here
* `   mov r0, #1` --> store decimal 1 in `r0`
* `   mov r1, #3` --> store decimal 3 in `r1`
* `   bl add2` --> branch to the label `add2` and store the address of the operation following this one in the register `lr`
* `   mov r3, #8` --> store decimal 8 in `r3`

* `add2:` --> label _add2_. whatever is under it is executes iff the operation `bl` executes
* `    add r2, r0, r1` --> store the result of the sum of the contents of `r0` and `r1` in `r2`
* `    bx lr` --> branch to (return to)  the address stored in `lr`

### notes
* look at the idea/concept of functions from a `asm` perspective
* focus on how to call and return to a location
* one way to do this is use branches. consider the following:

~~~asm
mov r0, #1
mov r1, #3
bal add2
mov r3, #5

add2:
    add r2, r0, r1
~~~

    decimal 1 is moved to `r0`, decimal 1 is moved to `r1`. branch `bal` always executes, therefore, execution moves to the label `add2`. the contents of `r0` and `r1` are added and stored in `r2`. notice that the instruction to store decimal 5 in `r3` never executes
* can the system return to the un-executed instruction?
    * yes
    * how? link register(s) and returns
    * consider the following:

~~~asm
mov r0, #1
mov r1, #3
bl add2
mov r3, #5

add2:
    add r2, r0, r1
    bx lr
~~~
    decimal 1 and 3 are stored in `r0` and `r1` respectively. the operation `bl add2` is executed. `bl` is `b`ranch `l`ink; it tells the system to: (1) branch to the label passed to it and (2) store the address of the operation following it in the link register aka `lr`.  execution moves to `add2`, the sum is stored in `r2` and the operation `bx lr` is executed. `bx` is `b`ranch and e`x`change; branch to the address contained in the argument (in this case, the address contained in `lr` is that of the op `mov r3, #5`) so that execution can be done from said address. decimal 5 can, finally, be stored in `r3`
* `bl` calls the function `add2` and `bx` returns
