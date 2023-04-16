# First Prog
refer to `1-first_program.asm`

### the code
* `.global _start` --> inform system(s)/people that there is a `_start` label ahead
* `_start:` --> a label. equivalent to a function in higher-level programming. the entry point; code under the label begins to execute here
    * `mov r0,#30` --> move (or store) the number 30 to `r0`
    * `mov r7,#1` --> move the number 1 to `r7`
    * `swi 0` --> send a software interrupt signal with code 0
### notes
* `mov`, `swi` etc are called op codes
* info in `r7` is either a system call or a system interrupt
* system reads `r7` compares value to a \[hash\]map and executes the task specified in said map (value `1` means _terminate a programme_)
* software interrupt return control to the system
* little endian vs big endian
    * lil endian --> the usual (sanskrit & brahmi) way of writing numbers: most significant number (bit, oct, digit, hex) on the left
        * e.g. decimal 40 = 4 tens and 0 ones; the _tens_ are on the left
        * decimal 123 = 1 hundreds, 2 tens and 3 ones; the _hundreds_ are on the left
        * decimal 0.123 = 0 ones, 1 tenths, 2 hundredths and 3 thousandths; the _ones_ are on the left
    * big endian --> the old arabic way of writing numbers: right to left. most significant number (bit, oct, digit, hex) on the right
        * e.g.decimal fourty is 4 tens and 0 ones. it would be represented thus: 04; _tens_ on the right
        * decimal one hundred and twenty three is 1 hundreds, 2 tens and 3 ones. it would be represented thus: 321; the _hundreds_ are on the right, _ones_ on the left
        * decimal zero point one two three is 0 ones, 1 tenths, 2 hundredths and 3 thousandths. it would be represented thus: 321.0; the _ones_ are on the right, _thousandths_ on the left