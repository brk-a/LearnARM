# Memory layout
worked with ARMv7 DE1-SoC 32-bit

### registers
* data can be written and accessed quickly (as quickly as elecrticity can move through the wires)
* can only store a word at a time
    * `word` in 32-bit arch is 4 bytes long (8 hex zeroes); 8 bits in 64-bit arch
    * `word` represents the max value of data that a register can carry
    * `double word` is, well, double a `word`
    * `half-word` (or `nibble`) is exactly that: half a `word`
    * `byte` is 8 bits
    * `bit` is a `0` or `1`
* used to represent simple forms/types of data  
* general purpose registers
    * registers `r1` to `r6`
* special purpose registers
    * `r7` --> register #7. reserved for system calls i.e. talking to the system
        * e.g. request for resources, terminate a programme etc
        * stores an `int` value in a map (probably hashmap) that it used for reference
    * `sp` --> stack pointer. stores the address of next available place in stack memmory
    * `lr` --> link register. stores the address of the caller of a function/routine so that execution can pick up from there when said function/routine returns
    * `pc` --> programme counter. stores the address of the next instruction to execute
    * `aspr` --> application programme status register. stores the state of the current instruction set
    * `cpsr` --> current programme status register. stores infomation about a programme (the status and control)
        * e.g. store the flag that signals to the system to include a `-` sign when one subtracts to numbers and the result is negative
        * store the flag that signals a carry (6 plus 7 is 3 carry 1), decimal point. remainder (3 divide by 2 is 1 remainder 1) etc
    * `spsr` --> saved programme status register. stores the value of the `cspr` when an exception is taken (occurs) so it can be retored after handling the exception. every exception handling mode can access its own `spsr`

### ram
* stores more data than a register
* data is accessed slower than in a register
* slower to write to

#### stack memory
* used to represent more advanced forms/types of data
    * e.g. lists/arrays of numbers
* addresses are four bytes apart because sizeof(pointer) = 4 bytes