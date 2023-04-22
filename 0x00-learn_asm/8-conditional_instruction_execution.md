# Conditional instruction execution
refer to [8-conditional_instruction_execution.asm](./8-conditional_instruction_execution.asm)

### the code
* `.global _start` --> inform system(s)/people that there is a `_start` label ahead
* `_start:` --> the entry point; code under the label begins to execute here
* `    mov r0, #2` --> store decimal 2 in `r0`
* `    mov r1, #4` --> store decimal 4 in `r1`
* `    cmp r0, r1` --> compare the contents of `r0` and `r1`

* `    addlt r2, #1` --> add one to the contents of `r2` iff the result of `cmp` is -ve, that is, contents of `r0` less than `r1` (result of addition is stored in `r2`, of course)
* `    movge r2, #2` --> store decimal 2  in `r2` iff the result of `cmp` is +ve or zero (_-ve or zero_ also means _"not negative"_), that is, contents of `r0` greater than or equal to `r1`
* `    subeq r2, #3` --> subtract three from the contents of `r2` iff the result of `cmp` is zero, that is, contents of `r0` equal to `r1` (result of subtraction is stored in `r2`, of course)

### notes
* idea is to execute a set of instruction based on the result of a comparison
* [comparisons and branches](./7-loops_branches.md) are one way to achieve this, however, there is a better way: op codes that execute iff a condition is met. such op codes reduce the need for complex, convoluted branches
* consider this:
    ~~~asm
    mov r0, #2
    mov r1, #4
    cmp r0, r1

    addlt r2, #1
    ~~~
    `addlt` stores decimal 1 in `r2` iff the result of the operation `cmp` is -ve, that is, the contents of `r0` are less than those of `r1`
* `addlt` is `add` iff `l`ess `t`han. it performs addition on specified operands iff the `lt` condition is met
* here are some ops that work the same way:

||add|sub|mul|mov|
|:---:|:---:|:---:|:---:|:---:|
|gt|addgt|subgt|mulgt|movgt|
|lt|addlt|sublt|mullt|movlt|
|ge|addge|subge|mulge|movge|
|le|addle|suble|mulle|movle|
|eq|addeq|subeq|muleq|moveq|
|ne|addne|subne|mulne|movne|
