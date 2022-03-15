This is a verilog module for use with the DE-10 Lite FPGA (top-level design not included). This is part of a lab 
assignment for my Digital Logic class in which we were tasked with driving the hex displays
on the DE-10 Lite using the 10 switches as input.

Part of the challange of this lab is to use two's complement and display a negative hexidecimal representation of
 the 10-bit input when appropriate.

-----------------------
Date: 3/12/2022
Version 1.1:
Driving the displays is working, however there is a bug with displying the negative values.

-----------------------
Date: 3/14/2022
Version 1.2

I reordered some of the module ports to better align the input/output ports with the MSB/LSB so that it's a bit more intuitive. Also reworked the twosCompliment and driveHex modules. V1.1 had wires of unnessecarily wide width (6 and 12-bits); the thought was that the extra bits would be helpful (they weren't). I scaled the wires back to 5-bits in order to use the MSB as a flag to indicate that the corresponding hex display should be turned off. I thought a sixth bit was necessary to display a negative sign (as 4-bits is enough for the 15 hex characters), however 5-bits is plenty to include both the 16th and 17th cases (off and negative). Finally, I completed a removeZeros modules in order to remove leading zeros from the output.

-----------------------
Date 3/15/2022
Version 1.3

ASSIGNMENT COMPLETE.
Added a second output to the checkSign module which is used as a flag for the negative sign. This flag is then passed into the newly added AddSign module which, as the name implied, adds a negative sign in the event that the input signal was interpreted as a signed number. Finally a negative case condition was added to the hexEncode module.
