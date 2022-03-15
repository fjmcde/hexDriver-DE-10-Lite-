//==================================//
// Name:        | Frank McDermott	  //
// File:        | driveHex.v        //
// Assignment:  | Lab 7: #5     	  //
// Version:     | v1.2              //
//==================================//

// NEED TO WORK OUT NEGATIVE
// module which takes a 10-bit signal as input from DE-10 Lite FPGA 
// switches and drives the 6 hex displays. uses twos complement to 
// display a signed or unsigned hexidecimal number.
module driveHex(
  input [9:0] in,
  output[7:0] hex5, hex4, hex3, hex2, hex1, hex0
  );

  // wires and regs
  wire [4:0] nib5 = 5'b10000; //OFF
  wire [4:0] nib4 = 5'b10000; //OFF
  wire [4:0] nib3 = 5'b10000; //OFF
  wire [4:0] nib2 = {1'b0, bin10[9:8]};
  wire [4:0] nib1 = {1'b0, bin10[7:4]};
  wire [4:0] nib0 = {1'b0, bin10[3:0]};

  // temp wires for intermediate input/output from modules
  wire [9:0] bin10;
  wire [4:0] temp1;
  wire [4:0] temp2;
  
  // check MSB on input signal
  checkSign check0(in, bin10);

  // remove leading zeros
  removeZeros r0(nib2, nib1, temp2, temp1);

  // drive hex displays
  hexEncode h5(nib5, hex5);
  hexEncode h4(nib4, hex4);
  hexEncode h3(nib3, hex3);
  hexEncode h2(temp2, hex2);
  hexEncode h1(temp1, hex1);
  hexEncode h0(nib0, hex0);
endmodule

// WORKING CORRECTLY
// checks the MSB of 10-bit input signal to determine whether to treat the input
// as signed or unsigned. If MSB is low (0), then treat as unsigned.
// If high (1) treat as signed.
module checkSign(input [9:0] in, output reg [9:0] out);
  wire [9:0] tc_wire;
  reg [9:0] temp;

  // create the hardware
  twosCompliment tc0(in, tc_wire);

  // give logic to the hardware
  always @(*) begin
      // if high, treat as signed
      if(in[9] == 1) begin
          temp <= tc_wire;
      end
      // else, treat as unsigned
      else begin
          temp <= in;
      end

      out <= temp;
  end
endmodule

// WORKING CORRECTLY
// takes 10-bit input signal, calculates it's two's complement
// then outputs the converted 10-bit signal
module twosCompliment(input [9:0] in, output [9:0] out);
  // invert input and add 1
  assign out = ~in + 10'b0000000001;
endmodule

module removeZeros(input [4:0] nib2, nib1, output [4:0] out2, out1);

  wire [4:0] zero = 5'b00000;
  wire [4:0] off = 5'b10000;

  assign out2 = (nib2 == zero) ? off : nib2;
  assign out1 = ((nib2 == zero) && (nib1 == zero)) ? off : nib1;
  
endmodule

// NEED TO WORK OUT NEGATIVE SIGN
// takes 5-bit input signal and outputs the corresponding 8-bit signal
// to be displayed as a hexidecimal character on a 7-segment hex display.
// the MSB has been coded as a "flag" to turn off the hex display
module hexEncode(input [4:0] in, output reg [7:0] hex_out);
  always @(in) begin
      case(in)
          5'b00000: hex_out = 8'b11000000; // 0
          5'b00001: hex_out = 8'b11111001; // 1
          5'b00010: hex_out = 8'b10100100; // 2
          5'b00011: hex_out = 8'b10110000; // 3
          5'b00100: hex_out = 8'b10011001; // 4
          5'b00101: hex_out = 8'b10010010; // 5
          5'b00110: hex_out = 8'b10000010; // 6
          5'b00111: hex_out = 8'b11111000; // 7
          5'b01000: hex_out = 8'b10000000; // 8
          5'b01001: hex_out = 8'b10011000; // 9
          5'b01010: hex_out = 8'b10001000; // A
          5'b01011: hex_out = 8'b10000011; // b
          5'b01100: hex_out = 8'b11000110; // C
          5'b01101: hex_out = 8'b10100001; // d
          5'b01110: hex_out = 8'b10000110; // E
          5'b01111: hex_out = 8'b10001110; // F
          5'b10000: hex_out = 8'b11111111; // OFF
      endcase
  end
endmodule