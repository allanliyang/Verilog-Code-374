module SevenSegmentEncode(
	
	input [7:0]OutPortdata,
	output reg [15:0]encodedValue
	
);

always @ (*) begin

	case (OutPortdata)
			
		8'h80 : encodedValue <= 16'b0111111100000000;
		8'h40 : encodedValue <= 16'b0110011000000000;
		8'h20 : encodedValue <= 16'b0101101100000000;
		8'h10 : encodedValue <= 16'b0000011000000000;
		8'h08 : encodedValue <= 16'b0000000001111111;
		8'h04 : encodedValue <= 16'b0000000001100110;
		8'h02 : encodedValue <= 16'b0000000001011011;
		8'h01 : encodedValue <= 16'b0000000000000110;
		8'h55 : encodedValue <= 16'b0110110101101101;
		
		default : encodedValue <= 16'b0111011100111000; // only shows up in wrong case (0xAL)
	
	endcase
	
end

endmodule
