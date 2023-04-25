# Hardware interactions
refer to [11-hardware_interactions.asm](./11-hardware_interactions.asm)
use the [ARMv7 DE1-SoC emulator](https://www.youtube.com/redirect?event=video_description&redir_token=QUFFLUhqa2h6cGFRdFVGcWFTV2dTeDNmQ1ZiRkRoS3M4d3xBQ3Jtc0ttaE1jeEpKTG1XSU5vLTJXSUdsRWlFdW1PV3ZLNUJCT3NFNklSUlVKQWcyM3V0Qlh5SFI2OTI5MWxZcjhEY0hTYldldG1JQmYwZnV4ck02UGhPODZCaWlMbW5DNUN4OFBuazRmVkFJcGdpbm9Qa09RUQ&q=https%3A%2F%2Fcpulator.01xz.net%2F%3Fsys%3Darm-de1soc&v=gfmRrPjnEw4) 

### the code
* `.equ SWITCH, 0xff200040` --> a constant called `SWITCH` whose value is set to the address of the switches in the emulator
* `.equ LED, 0xff200000` --> a constant called `LED` whose value is set to the address of the LEDs in the emulator

* `.global _start` --> inform system(s)/people that there is a `_start` label ahead
* `_start:` --> the entry point; code under the label begins to execute here
* `    ldr r0, =SWITCH` --> store the contents of the address of constant `SWITCH` in `r0`
* `    ldr r1, [r0]` --> store the contents of the address in register `r0` in `r1`

* `    ldr r0, =LED` --> store the contents of the address of constant `LED` in `r0`
* `    str r1, [r0]` --> 

### notes
* idea is to see how switches and LEDs work
* switches are inputs and LEDs are outputs; first principles i/o
* why use `equ`?
    * the numbers involved are large; they cannot be loaded directly onto a single register (limits in ARM). also, it is more efficient to, simply, pass the address(es) of hardware devices
* the switches work like, well, a switch. two states: on and off. said states are used to represent the bits 1 and 0 respectively. There are nine switches, that is, nine slots where each slot can be 0 or 1; default state is 0. example: decimal 137 (0b010001001) is input this way

|slot no.|9|8|7|6|5|4|3|2|1|
|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|
|bits|0|1|0|0|0|1|0|0|1|

the bits in each switch can be set independently. their states are combined into a single output and stored in a memory location; this is how the switches work as an input device
* the LEDs work the same as the switches only in reverse: they receive input from various memory locations (the switches, for example) and turn on or off (light up) accordingly; default state is off. their combined states are read as a single output; LEDs, therefore, are output devices