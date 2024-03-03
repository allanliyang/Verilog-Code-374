
module ConFFLogic (
	
	input clear, clock, read, 
	input ConIn,
	input [31:0]IR,
	input [31:0]BusMuxOut, 				
	output wire Con
);

parameter	zero = 4'b0000, nonZero = 4'b0001, positive = 4b'0010, negative = 4b'0011;


reg busBitInput; // Bit entering and gate from the bus
reg [3:0]c2;

initial busBitInput = 1'b0;
initial c2 = [22:19]IR;
q = 1'b0; // Initializing q



always @ (posedge clock)

		begin
		
			case (c2)
			
				zero: begin //00 - Branches if BusMuxOut is = 0
								busBitInput <= ~(&BusMuxOut);
					end
								
								
				
				nonZero: begin //01 - Branches if BusMuxOut is != 0
								busBitInput <= ~(~(&BusMuxOut));
					end
								
				
				positive: begin //10 - Branches if BusMuxOut is >= 0
								busBitInput <= [31]BusMuxOut;
					end
				
				negative: begin //11 - Branches if BusMuxOut is < 0
								busBitInput <= ~[31]BusMuxOut;
					end
			endcase
			q <= busBitInput;
		end
		assign Con = q;
	
	
endmodule
