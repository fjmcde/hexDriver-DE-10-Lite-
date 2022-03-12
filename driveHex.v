//==================================//
// Name:        | Frank McDermott	//
// File:        | driveHex.v        //
// Assignment:  | Lab 7: #5     	//
// Version:     | v1.1              //
//==================================//

// module which takes 10-bit signal from DE-10 Lite FPGA switches
// and drives the 6 hex displays. uses twos complement to display
// signed and unsigned numbers.
module driveHex(
    input [9:0] in,
    output[7:0] hex0, hex1, hex2, hex3, hex4, hex5
    );

    // wires and regs
    wire [5:0] nib0 = bin[3:0];
    wire [5:0] nib1 = bin[7:4];
    wire [5:0] nib2 = bin[9:8];
    wire [5:0] nib3 = 6'b111111; //OFF
    wire [5:0] nib4 = 6'b111111; //OFF
    wire [5:0] nib5 = 6'b111111; //OFF
  	wire [11:0] bin;
    
    // check MSB on input signal
    checkMSB check0(in, bin);

    // drive hex displays
    hexEncode h0(nib0, hex0);
    hexEncode h1(nib1, hex1);
    hexEncode h2(nib2, hex2);
    hexEncode h3(nib3, hex3);
    hexEncode h4(nib4, hex4);
    hexEncode h5(nib5, hex5);
endmodule

module checkMSB(input [9:0] in, output reg [11:0] out);
  	wire [9:0] tc_wire;
  	reg [11:0] temp;

    // create the hardware
    twosCompliment tc0(in, tc_wire);

    // give logic to the hardware
	 always @(*) begin
        // if high, treat as signed
        if(in[9] == 1) begin
          	temp[9:0] <= tc_wire;
          	temp[11] <= 1;
				out <= temp;
        end
        // else, treat as unsigned
        else begin
          	temp[9:0] <= in;
				out <= temp;
        end
    end
endmodule

module twosCompliment(input [9:0] in, output [9:0] out);
    // invert input and add 1
    assign out = ~in + 10'b0000000001;
endmodule

module hexEncode(input [5:0] in, output reg [7:0] hex_out);
    always @(in) begin
        case(in)
            6'b000000: hex_out = 8'b11000000; // 0
            6'b000001: hex_out = 8'b11111001; // 1
            6'b000010: hex_out = 8'b10100100; // 2
            6'b000011: hex_out = 8'b10110000; // 3
            6'b000100: hex_out = 8'b10011001; // 4
            6'b000101: hex_out = 8'b10010010; // 5
            6'b000110: hex_out = 8'b10000010; // 6
            6'b000111: hex_out = 8'b11111000; // 7
            6'b001000: hex_out = 8'b10000000; // 8
            6'b001001: hex_out = 8'b10011000; // 9
            6'b001010: hex_out = 8'b10001000; // A
            6'b001011: hex_out = 8'b10000011; // b
            6'b001100: hex_out = 8'b11000110; // C
            6'b001101: hex_out = 8'b10100001; // d
            6'b001110: hex_out = 8'b10000110; // E
            6'b001111: hex_out = 8'b10001110; // F
            6'b100000: hex_out = 8'b10111111; // -
            6'b111111: hex_out = 8'b11111111; // OFF
          	default: hex_out = 8'b10110110; // ---
        endcase
    end
endmodule