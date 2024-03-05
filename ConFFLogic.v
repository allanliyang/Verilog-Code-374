
module ConFFLogic (
	
	input ConIn,
	input [31:0]IRout,
	input [31:0]BusMuxOut,
	output wire ConFFOut
);

parameter	zero = 2'b00, nonZero = 2'b01, positive = 2'b10, negative = 2'b11;

reg [1:0]C2;
reg Q;

initial begin

	C2 = IRout[20:19];
	Q = 1'b0; // Initializing q
	
end


always @ (posedge ConIn) begin // NOTE: Check if this is the right input for FF
		
		case (C2)
			//00 - Branches if BusMuxOut is = 0
			zero: 		Q <= (~|BusMuxOut);	// reduction NOR
			
			//01 - Branches if BusMuxOut is != 0
			nonZero: 	Q <= (|BusMuxOut); // reduction OR
								
			//10 - Branches if BusMuxOut is >= 0
			positive:	Q <= ~BusMuxOut[31];
			
			//11 - Branches if BusMuxOut is < 0
			negative:	Q <= BusMuxOut[31];
		endcase
		
	end
	
	// NOTE: Update outputs for branching cases
	assign ConFFOut = Q;
	
endmodule
