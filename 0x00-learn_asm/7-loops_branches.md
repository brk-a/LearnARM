# Loops with branches
refer to [7-loops_branches.asm](./7-loops_branches.asm)

### the code
* `.global _start` --> inform system(s)/people that there is a `_start` label ahead
* `.equ endlist, 0xaaaaaaaa` --> a constant called `endlist` whose value is set to hex 2,863,311,530. the op code `equ` is used to create constants

* `_start:` --> the entry point; code under the label begins to execute here
* `    ldr r0, #list` --> store the contents of the address of `list` in `r0` (think of an array in higher-level languages, C especially. The address of an array is the address of the first element of said array. also, elements of an array are stored sequentially starting at the starting address of said array)
* `    ldr r3, #endlist` --> store the contents of the address of `endlist` in `r3`
* `    ldr r1, [r0]` --> store the contents of the address in `r0` into `r1`
* `    add r2, r2, r1` --> store the sum of the contents of `r2` and `r1` in `r2`

* `loop:` --> label _loop_. this is where the loop is implemented
* `    ldr r1, [r0, #4]!` --> add 4 to the address at `r0` then store the contents of the resulting address into `r1`. at the end of the operation, the value of the address in `r0` increases by 4
* `    cmp r1, r3` -->  compare the contents of `r1` and `r3`
* `    beq exit` --> executes iff the result of `cmp` is zero; that is, the contents of `r1` are the same as those of `r3`. in this case `beq` directs to the label `exit`
* `    add r2, r2, r1` --> store the result of the sum of the contents of `r2` and `r1` in `r2`
* `    bal loop` --> always executes; see [6-conditionals_branching.md](./6-conditionals_branches.md). in this case `bal` directs to the label `.loop`

* `exit:` --> label _exit_. code under this label executes when `beq` directs to here. there is no code under `exit`, therefore, `loop` terminates


* `.data` --> _data_ section. used to store data in the stack
* `list:` --> a declaration. _data_ is of "type" `list`
* `    .word 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10`-->  see [2-addressing_modes.md](./2-addressing_modes.md)

### notes
* look at looping as a consequence of comparator and branching ops
* loops, of course, allow instructions to be repeated
* if the code can be made to branch to a location it, conversely, can be made to go back to where it branched from. the conditions under which that operation will be done control it. that, right there, ~~~is a violation, personally I wouldn't have it~~~ is a loop
* the code creates a list (an array), traverses it and returns a running total with each step
    * question: how does the system know that it has reached the end of the list?
        * good question. an indicator; an indicator is how the system knows. there are a number of ways of setting an indicator. here are two:
            1. empty slots in memory (aka uninitialised memory). there, always, is a placeholder value to show that a memory slot is empty. in this case, the placeholder is 0xaaaaaaaa (2 billion and some change in decimal)
            2. null character in higher-level programming, especially C. a string, in C, is, simply, an array of characters terminated by the null character `\0`. example: the string "cat" in mem will be:

            |  0  |  1  |  2  |  3  |
            |:---:|:---:|:---:|:---:|
            |  c  |  a  |  t  | \0  |
            
        * ARM limits the size of _literals_ to two hex values; `cmp` will not work as expected. here is where _constants_ excel. the op code/key word `equ` creates a constant. said constant does not have the size limit of a literal. in this case `equ` creates a constant called `endlist` and assigns the empty slot placeholder value to it. `cmp` can now be used to find the end of the list
        * uninitialised memory placeholders vary by architecture, manufacturer etc; pay attention to that
            * alternatively, define your own and apply it in the system
        