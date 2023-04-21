# Conditionals and branches
refer to [`6-conditionals_branches.asm`](./6-conditionals_branches.asm)

### the code
* `.global _start` --> inform system(s)/people that there is a `_start` label ahead 
* `_start:` --> the entry point; code under the label begins to execute here
* `   mov r0, #1` --> store decimal 1 in `r0`
* `   mov r1, #2` --> store decimal 2 in `r1`
* `   cmp r0, r1` --> compare the contents of `r0` and `r1` (order is important because comparison is a subtraction operation)
* `   bal default` --> `b`ranch `al`ways. always executes; that is to say, when result of `cmp` is -ve, zero or +ve. execute code under the label `default`
* `   bgt greater` --> `b`ranch `g`reater `t`han. executes when result in `cmp` is +ve. execute code under label `greater`
* `   bge greater_equal` --> `b`ranch `g`reater than or `e`qual to. executes when result in `cmp` is +ve or zero; that is to say, result is not -ve. execute code under label `greater_equal`
* `   blt lesser` --> `b`ranch `l`esser `t`han. executes when result in `cmp` is -ve. execute code under label `lesser`
* `   ble lesser_equal` --> `b`ranch `l`esser than or `e`qual to. executes when result in `cmp` is -ve or zero; that is to say, result is not +ve. execute code under label `lesser_equal`
* `   beq equal` --> `b`ranch `eq`ual to. executes when result in `cmp` is zero. execute code under label `equal`
* `   bne not_equal` --> `b`ranch `n`ot `e`qual to. executes when result in `cmp` is anything other than zero. execute code under label `not_equal`

* `default:` --> label `default`. code under the label is executed when the associated branch prompts it
* `   mov r2, #0` --> store decimal 0 in `r2`

* `greater:` --> label `greater`. code under the label is executed when the associated branch prompts it
* `   mov r2, #1` --> store decimal 1 in `r2`

* `greater_equal:` --> label `greater_equal`. code under the label is executed when the associated branch prompts it
* `   mov r2, #2` --> store decimal 2 in `r2`

* `lesser:` --> label `lesser`. code under the label is executed when the associated branch prompts it
* `   mov r2, #3` --> store decimal 3 in `r2`

* `lesser_equal:` --> label `lesser_equal`. code under the label is executed when the associated branch prompts it
* `   mov r2, #4` --> store decimal 4 in `r2`

* `equal:` --> label `equa;`. code under the label is executed when the associated branch prompts it
* `   mov r2, #5` --> store decimal 5 in `r2`

* `not_equal:` --> label `not_equal`. code under the label is executed when the associated branch prompts it
* `   mov r2, #6` --> store decimal 6 in `r2`

### notes
* use the output of an operation to determine the next operation
    * think `if-else` in higher-level languages
* comparators and branches
    * comparators, well, compare two pieces of data based on criteria, say, greater than, lesser than, equal to and so on
    * branches allow a programme to move to a specified location within a programme based on the result of the comparison operation (move to and execute the required section of a block of code)
* op code `cmp` performs the role of comparator
    * question: how?
        * glad you asked. take the example 
        ~~~asm
        mov r0, #1
        mov r1, #0
        cmp r0, r1
        ~~~
        `cmp` first performs `r0` minus `r1`. the result takes on one of three possible states:  positive number (meaning the contents of `r0` greater than `r1`), negative number (`r0` less than `r1`) or zero (`r0` == `r1`). it then sets the `C`, `N` or `Z` flag respectively in the `cpsr`
    * say the result is positive (`r0` greater than `r1`). the result in `cmp` sets the `C` flag in the `cpsr` and directs to `bgt` (branch greater than). `bgt`, obviously, is a branch. it takes a _label_. said label is where the code for the _greater than_ branch is, therefore, it will be executed. once done, the programme carries on with the next line after the code in the relevant label 
        * all well and good but, what happens when the label does not exist?
            * not to worry; the programme carries on to the next line as though the `bgt` did not exist
        * notice that the code after the `bgt` is executed anyway; this might not be the desired effect. this is where branch always `bal` comes in. `bal` _always_ executes (think of the `default` case in `switch-case`). if `bgt` does not execute (e.g. `r0` less than `r1`), `bal` is performed
            * instructions in `asm` are run sequentially. consider this:
            ~~~asm
            mov r0, #1
            mov r1, #2
            cmp r0, r1
            bal default
            bgt greater

            greater:
                mov r2, #1

            default:
                mov r2, #2
            ~~~
            the result of `cmp` sets the `N` flag in the `cpsr`. `bal` executes, therefore, the code under the label `default` executes too. decimal 2 is stored in `r2`. the operation `bgt` never executes

            consider this also:
            ~~~asm
            mov r0, #3
            mov r1, #2
            cmp r0, r1
            bal default
            bgt greater

            greater:
                mov r2, #1

            default:
                mov r2, #2
            ~~~
            the result of `cmp` sets the `C` flag in the `cpsr`. `bal` executes, therefore, the code under the label `default` executes too. decimal 2 is stored in `r2`. the operation `bgt` never executes. the code under label `greater` never executes because of how the labels are arranged, therefore, the end result is decimal 2 stored in `r2`
            * what happens when `bgt` comes before `bal` in both cases?
            ~~~asm
            mov r0, #1
            mov r1, #2
            cmp r0, r1
            bgt greater
            bal default

            greater:
                mov r2, #1

            default:
                mov r2, #2
            ~~~
            the result of `cmp` sets the `N` flag in the `cpsr`. `bgt`  never executes, therefore, the code under the label `greater` does not execute. `bal` executes. decimal 2 is stored in `r2`

            ~~~asm
            mov r0, #3
            mov r1, #2
            cmp r0, r1
            bgt greater
            bal default

            greater:
                mov r2, #1

            default:
                mov r2, #2
            ~~~
            the result of `cmp` sets the `C` flag in the `cpsr`. `bgt` executes, therefore, the code under the label `greater` executes too. decimal 1 is stored in `r2`. the operation `bal` executes after `bgt`, therefore, the end result is decimal 2 stored in `r2`
            * idea is to set branches properly to avoid bugs and/or undesired effects
