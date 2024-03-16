
module ConFFLogic (
	
	input ConIn,
	input [31:0]IRout,
	input [31:0]BusMuxOut,
	output wire ConFFOut
	
);


	parameter	zero = 2'b00, nonZero = 2'b01, positive = 2'b10, negative = 2'b11;


	reg [1:0]C2;
	reg Q;
	reg [31:0]Ra;


	initial begin

	C2 = 2'b00;
	Q = 1'b0; // Initializing q
	Ra = 32'b0;
	
	end


	always @ (*) begin // NOTE: Check if this is the right input for FF
		
		
		C2 <= IRout[20:19];
		Ra <= BusMuxOut;
		
		
		if (ConIn) begin
		
			case (C2)
		
				//00 - Branches if BusMuxOut is = 0
				zero: 		Q <= (~|Ra);	// reduction NOR
			
				//01 - Branches if BusMuxOut is != 0
				nonZero: 	Q <= (|Ra); // reduction OR
								
				//10 - Branches if BusMuxOut is >= 0
				positive:	Q <= ~Ra[31];
			
				//11 - Branches if BusMuxOut is < 0
				negative:	Q <= Ra[31];
				
				default:		Q <= 0;
				
			endcase
		
		end
	end
	
	
	// NOTE: Update outputs for branching cases
	assign ConFFOut = Q;
	
	
endmodule
