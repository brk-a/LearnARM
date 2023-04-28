# Debug using GDB
use the code in [13-print_strs_to_terminal.s](./13-print_strs_to_terminal.s)

### the code 
no code to explain

### notes
* idea is to debug `.asm` programmes using `gdb` on a linux environment
* `gdb` is GNU Debugger; read about it [here](https://www.sourceware.org/gdb/) and [here](https://bob.cs.sonoma.edu/IntroCompOrg-x64/bookap3.html)
* is the way _real_ assembly programmers debug; also used a lot by C and C++ programmers
* how is `gdb` used?
    * good question. here we go...
        1. call `gdb` with the name of the executable file to debug

            ~~~bash
            gdb 13-hello_world
            ~~~

        2. \[optional\] add breakpoints. a breakpoint is a point in the program where the code will stop executing. allows one to see what the state of memory, registers etc is at that point in execution 
        *\[good practice\] use labels as break points*

            ~~~bash
            break _start
            ~~~

        3. run the programme in debug mode; this is similar to _step into_ on an emulator

            ~~~bash
            run
            ~~~

        programme will run one step at a time until it hits a breakpoint or, if no breakpoints, the end.
        notice that one cannot tell what is going on use the following:
            
            ~~~bash
            layout asm
            ~~~

        the layout shows the instructions in the application. would be great if the registers could be shown too; well, there are two ways:
        one: see what is inside a particular register, say, `r0`

        ~~~bash
        info register r0
        ~~~
        
        two: see what is inside all the registers (same way as the emulator)

        ~~~bash
        layout regs
        ~~~

        there should be three views on screen (split-screen-type): (1) the registers at the top, (2) the instructions in the middle and (3) the terminal at the bottom. use `CTRL-X-O` (`control-X-O` on mac)to navigate the first two
        4. step into the next instruction

            ~~~bash
            stepi
            ~~~
        
        the current instruction executes and the next one is on stand-by

        5. repeat step 4 until:
            * an error is identified or
            * the programme terminates
        6. \[optional\] run the programme to its end starting at the current breakpoint

            ~~~bash
            run
            ~~~

        system will ask whether this is the action you want to take; type `y`. delete breakpoints using the `clear` command; more on this [here](https://ftp.gnu.org/old-gnu/Manuals/gdb/html_node/gdb_31.html)
    * how does one see a string in stack memory?
        * using one's eyes, of course. jokes aside, here is how:
        * use the command `x` on terminal and pass it an address, the number of pieces of mem to examine and a format; `x` is e`x`amine
        * say the string _hello, world_ is stored in the stack mem starting at address 0x01 and that the address `0x01` is stored in `r1`. do this

            ~~~bash
            x/10x $r1
            ~~~

        this tells the system to examine 10 units of memory starting at the address stored in `r1` and show the contents in hexadecimal format

        more formats:
        1. `x/10d $r1` -->  examine 10 units of memory starting at the address stored in `r1` and show the contents in decimal format
        2. `x/10u $r1` -->  examine 10 units of memory starting at the address stored in `r1` and show the contents in unsigned decimal format
        3. `x/10s $r1` -->  examine 10 units of memory starting at the address stored in `r1` and show the contents in signed decimal format
        4. `x/10o $r1` -->  examine 10 units of memory starting at the address stored in `r1` and show the contents in octal format
        5. `x/10b $r1` -->  examine 10 units of memory starting at the address stored in `r1` and show the contents in binary format
        6. `x/10c $r1` -->  examine 10 units of memory starting at the address stored in `r1` and show the contents in character format (ascii text, with ascii code)
        7. `x/15d $r1` -->  examine 15 units of memory starting at the address stored in `r1` and show the contents in decimal format

        for the string _hello, world_, the following will apprear

            |0x01|0x02|0x03|0x04|0x05|0x06|0x07|0x08|0x09|0x0a|0x0b|0x0c| 0x0d|0x0e| 0x0f| 0x10|
            |:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|
            |104 'h'|101 'e'|108 'l'| 108 'l'|111 'o'|44 ','|32 ' '|119 'w'|111 'o'|114 'r'|108 'l'|100 'd'|10 '\n'|0 '\000'| ...| ...|
        
        notice the `0 '\000'` character at the end of the string; that is the [null character](https://www.dictionary.com/browse/null-character)
* as always, [RTFM](https://ftp.gnu.org/old-gnu/Manuals/gdb/html_node/gdb_toc.html)