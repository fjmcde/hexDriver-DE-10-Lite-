//==================================//
// Name:        | Frank McDermott	//
// File:        | driveHex-tb.v     //
// Assignment:  | Lab 7: #5     	//
// Version:     | v1.1              //
//==================================//


// testbench to test the driveHex module
module driveHex-tb;
  reg [9:0] in;
  wire [7:0] hex0;
  wire [7:0] hex1;
  wire [7:0] hex2;
  wire [7:0] hex3;
  wire [7:0] hex4;
  wire [7:0] hex5;
  
  
  //twosCompliment c0(in, out);
  driveHex d0(in, hex0, hex1, hex2, hex3, hex4, hex5);
  
  initial begin
    $monitor("in: %b, 0: %b, 1: %b, 2: %b, 3: %b, 4: %b, 5: %b", in, hex0, hex1, hex2, hex3, hex4, hex5);
    #10
    in = 10'b1111111111;
    $finish;
  end
    
endmodule