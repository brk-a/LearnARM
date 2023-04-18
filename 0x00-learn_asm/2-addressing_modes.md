# Addressing modes
refer to [`2-addressing_modes.asm`](./2-addressing_modes.asm)

### the code
* `.global _start`--> inform system(s)/people that there is a `_start` label ahead
* `_start:`--> a label. equivalent to a function in higher-level programming. the entry point; code under the label begins to execute here
*   `ldr r0,=list` --> `ldr` (load data into register). used to, well, load data into a register. here, the address of the beginning of the `list` is loaded/stored into register `r0`. _(aside: so this is how C arrays work. interesting)_ 
*   `ldr r1,[r0]` --> store the contents of the address in `r0` into `r1`. the number 4 is stored in `r1`. _(aside: think x = *ptr in C)_
*   `ldr r2,[r0,#4]` --> add 4 to the address at `r0` then store the contents of the resulting address into `r2`. the number 5 is stored in `r2` and the value of the address in `r0` remains as it was before the operation. _(aside: is this x = *++ptr in C?)_
*   `ldr r3,[r0,#4]!` --> add 4 to the address at `r0` then store the contents of the resulting address into `r3`. the number 5 is stored in `r3` and the value of the address in `r0` increases by 4. _(aside: is this x = *++ptr in C?)_
*   `ldr r4,[r0],#4` --> add 4 to the address at `r0` then store the contents of the initial address of `r0` into `r4`. the number 4 is stored in `r4` and the value of the address in `r0` increases by 4. _(aside: is this x = *ptr++ in C?)_

* `.data` --> a section; `data` section. used to store data in the stack
* `list:` --> a declaration. data will be of "type" `list` 
*   `.word 4,5,-9,1,0,2,-7` --> `.word` tells the system that everything that follows it is of "type" [word](./0-mem_layout.md). the numbers that follow are the _members_ of the `list` 
### notes
* immediate addressing. move a constant to a register
    * e.g. ``` mov r0,30 ``` says store decimal 30 inside register `r0`
* direct addressing. store the address of the location containing data into a register
    * e.g. ``` ldr r0,=list ``` says store the address of the beginning of `list` into register `r0`
* register direct addressing. move a value stored in a register to another register
    * e.g. ``` mov r1,r0 ``` says store the contents of  register `r0` in register `r1`
* register indirect addressing. store the contents of the address stored in a register into another register
    * ``` ldr r1,[r0] ``` --> store the contents of the address in `r0` into `r1`
* register indirect addressing with offset. add an offset to an address in a register then store the data contained in the resulting address into another register
    * e.g. ``` ldr r2,[r0,#4] ``` --> add 4 to the address at `r0` then store the contents of the resulting address into `r2`
    * the number 5 is stored in `r2`
    * the value of the address in `r0` remains as it was before the offset was added
* pre-increment addressing. add an offset to an address in a register then store the data contained in the resulting address into another register
    * e.g. ``` ldr r3,[r0,#4]! ``` --> add 4 to the address at `r0` then store the contents of the resulting address into `r3`
    * the number 5 is stored in `r3`
    * the value of the address in `r0` increases by 4.
* post-increment addressing. store the contents of theaddress of a register in another register then add an offset to the address contained in the first register
    *  e.g. ``` ldr r4,[r0],#4 ``` --> add 4 to the address at `r0` then store the contents of the initial address of `r0` into `r4`
    * the number 4 is stored in `r4`
    * the value of the address in `r0` increases by 4