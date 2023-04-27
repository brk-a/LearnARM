# Print strings to terminal
refer to [13-print_strs_to_terminal.s](./13-print_strs_to_terminal.s)

### the code
* `.global _start` --> inform system(s)/people that there is a `_start` label ahead
* `_start:` --> the entry point; code under the label begins to execute here
* `    mov r0, #1` --> store decimal 1 in `r0`. tells the system to use `stdout`. decimal 0 tells the system to use `stdin`, decimal 2 is for `stderr` and other integers are for other [file descriptors](https://www.ibm.com/docs/en/aix/7.1?topic=volumes-using-file-descriptors), e.g. a text file, image file etc
* `    ldr r1, =message` --> store the address of the beginning of `message` in`r1`
* `    ldr r2, =len` --> store the address of `len` in `r2`
* `    mov r7, #4` --> store decimal 4 in `r7`. register `r7` is a special register; its contents tell the system what to do when it takes over. code 4 tells the OS to write (to wherever)
* `    swi 0` --> a system call. pause the current programme, hand over control to the system and have it do what the contents of `r7` say it should. `swi` is `s`oft`w`are `i`nterrupt

* `    mov r7, #1` --> store decimal 1 in `r7`. code 1 in `r7` tells the system to exit the programme
* `    swi 0` --> hand over control to the system and have it do what the contents of `r7` say it should

* `.data:` --> the `data` section. used to store data in the stack
* `message:` --> a declaration. data will be of "type" `message`
* `    .string "hello, world\n"` --> the string to be output, terminated by a  _[null character](https://www.dictionary.com/browse/null-character)_. `.string` is one way to declare text
* `len = .-message` --> declare a variable, `len`, containing the length of the string in `message`

* alternatives to `.string`
    * .ascii --> characters follow `ascii` format; read about ASCII [here](https://www.ascii-code.com/). said characters do not have a null character (null terminator, if you like)
    * .asciz --> characters follow `ascii` format but have a null character appended
    * .string --> synonym/alias of `.asciz`

### notes
* idea is to see the basics of OS interactions by outputting data to _stdout_
* _finally_ get to write "Hello, world"
* to cover: system calls and system interrupts
* code used is compatible with a ARM-based device
* three pieces of info required to print _hello, world_ to the screen:
    1. where the message/text/data will be written to
    2. what to output
    3. the length of the output
* the first requirement is fulfilled by 

~~~asm
mov r0, #1
~~~

`stdout` can be a terminal window etc. any valid file descriptor can be used
* the second requirement is fulfilled by 

~~~asm
ldr r1, =message
~~~

think of the address of `message` as a [buffer](https://www.tutorialspoint.com/what-do-you-mean-by-buffer-in-c-language)

* the third requirement is fulfilled by 

~~~asm
ldr r2, =len
~~~

* how is _hello, world_ printed on the screen?
    * good question; watch closely

~~~asm
mov r7, #4
swi 0

mov r7, #1
swi 0
~~~

`r7` stores an integer. said int is a code that tells the OS what to do when it is called. calling the OS means _interrupting the software_ (pause the current programme, hand over control to the OS, let the OS, well, OS then hand over control to current programme). code 4 tells the OS to write to wherever. OS checks `r0`, `r1` and `r2` and acts accordingly
    
to exit, decimal 1 is stored in `r7` (code 1 means _terminate the current programme_). execute `swi` again this time with 1 in `r7`. OS gets control, reads `r7`and terminates the programme

