//==================================//
// Name:        | Frank McDermott	  //
// File:        | driveHex-tb.v     //
// Assignment:  | Lab 7: #5     	  //
// Version:     | v1.2              //
//==================================//

`include "driveHex.v"

// testbench to test the driveHex module
module driveHex_tb;
  reg [9:0] in;
  wire [7:0] hex5;
  wire [7:0] hex4;
  wire [7:0] hex3;
  wire [7:0] hex2;
  wire [7:0] hex1;
  wire [7:0] hex0;
  
  driveHex d0(in, hex5, hex4, hex3, hex2, hex1, hex0);
  
  initial begin
    #10
    in = 10'b1000000000; // change as needed
    $monitor(
      "in: %b, 5: %b, 4: %b, 3: %b, 2: %b, 1: %b, 0: %b", 
      in, hex5, hex4, hex3, hex2, hex1, hex0
      );
    $finish;
  end
    
endmodule