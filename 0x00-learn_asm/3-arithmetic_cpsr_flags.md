# Arithmetic and `cpsr`flags
refer to [`3-arithmetic_cpsr_flags.asm`](./3-arithmetic_cpsr_flags.asm)

### the code
* `.global _start` --> inform system(s)/people that there is a `_start` label ahead 
* `_start:` --> the entry point; code under the label begins to execute here
*   `mov r0, #5` --> store decimal 5 in `r0`
*   `mov r1, #7` --> store decimal 7 in `r1`
*   `add r2, r0, r1 ;r2 = r0 + r1` --> store the sum of the contents of `r0` and `r1` in `r2`. The part `;r2 = r0 + r1` is a comment
*   `sub r3, r0, r1` --> store the difference of the contents of `r0` and `r1` in `r3`. order is important here; this code says _"subtract the contents of `r1` from the contents of `r0`"_. that is, `r0` minus `r1`
*   `mul r4, r0, r1` --> store the product of the contents of `r0` and `r1` in `r4`
*   `subs r5, r0, r1` --> store the difference of the contents of `r0` and `r1` in `r5` then turn on the _negative_ flag (`N`). said flag is in `cpsr`
*   `adds r6, r0, r1` --> store the sum of the contents of `r0` and `r1` in `r6` then turn on the _carry_ flag (`C`). said flag is in `cpsr`
*   `adc r2, r1, r0 ; r2 = r0 + r1 + carry` --> store the sum of the contents of `r0`, `r1` and _carry_ from a previous operation in `r2`

### notes
* op codes `add`, `sub` and `mul` perform the arithmetic operations `+`, `-` and `*` respectively
* op codes `adds` and `subs` work as `add` and `sub` do and they set flags in the `cpsr`. said flags signal various operations example: negative numbers, carry, overflow etc
* op code `adc` allows the system to use a _carry_ from a previous operation
* the way large numbers and negative numbers are stored in assembly makes them look the same
    * e.g. 5 - 7 = -2 and 0xffffffff - 0x00000001 = 0xfffffffe. `-2` and `0xfffffffe` are stored as `0xfffffffe` in the register
    * question: how does the system discern?
        * eeeaasy; flags in the `cpsr`. said flags are: NZCV; `N`egative, `Z`ero, `C`arry, o`V`erflow. the latter is also written as `O`verflow _(NZCO?)_
    * question: how are the flags set?
        * QED; specific op codes. example: `subs r5, r0, r1` says _store the difference of the contents of `r0` and `r1` in `r5` then turn on the _negative_ _flag (`N`)_. notice the _`s`_ at the end of `sub`
        * caveat: this operation is costlier than conventional `sub`; use only when needed
        * use  `subs` when you are certain that there will be negative numbers or when you are not in control of the input (example: an online calculator)
        * `C` flag is set when a number is too large to fit into a register (that is, overflows the register). example `0xffffffff + 0x00000001` will overflow a 32-bit register.  use `adds` instead of `add`
            * _carry_ will be set to 1 if `C` is on, 0 otherwise