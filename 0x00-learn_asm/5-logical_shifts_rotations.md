# Logical shifts and rotations (part 1)
refer to [`5-logical_shifts_rotations.asm`](./5-logical_shifts_rotations.asm)

### the code


### notes
* logical shifts and rotations allow the user to manipulate data at the bit level
* look at this from a bit perspective, not an octal, decimal or hexadecimal one
* two ways to do logical shifts:
    * logical shift to the left ```lsl``` --> move bits one position to the left of the starting position
        * e.g. binary 10 (or 0b00001010) shifted left becomes binary 20 (or 0b00010100)
        * notice how the rightmost four bits in binary 10 are now the second, third, fourth and fifth rightmost bits in binary 20
        * notice how shifting binary 10 to the left results in binary 20 (20 equals 10 times 2); this is not a coincidence
        * shifting to the left once is, simply, multiplying by two
    * logical shift to the right ```lsr```  --> move bits one position to the right of the starting position
        * e.g. binary 10 (or 0b00001010) shifted right becomes binary 5 (or 0b0000101)
        * notice how the second, third and fourth rightmost in binary 10 are now the three  rightmost bits in binary 5 (the rightmost zero is, simply, discarded)
        * notice how shifting binary 10 to the right results in binary 5 (5 equals 10 divide by 2); this is not a coincidence
        * shifting to the right once is, simply, dividing by two
* rotation ```ror ``` --> 
