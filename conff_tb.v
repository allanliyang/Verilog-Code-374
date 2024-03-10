  
`timescale 1ns/10ps
module conff_tb();


	reg clock;

	reg ConIn;
	reg [31:0]IRout, BusMuxOut;
	wire ConFFOut;


	reg [4:0]Present_state = 4'b00000;


	ConFFLogic ConFF(ConIn, IRout, BusMuxOut, ConFFOut);


	initial begin clock = 0; Present_state = 4'b0000; end
	always #10 clock = ~clock;
	always @ (negedge clock) Present_state = Present_state + 1;


  always @ (Present_state) begin
	
			case (Present_state)
					
					5'b00001 : begin 	// default case, clear registers and set all signals to low
						
						ConIn <= 0;
						IRout <= 32'b0;
						BusMuxOut <= 32'hF;
						
					end
					
					
					// check brzr
					5'b00010 : begin	
						//BusMuxOut <= 32'h0;	// takes branch 
						BusMuxOut <= 32'h1;	// does not take branch
						ConIn <= 1; 
						
						
						#15 BusMuxOut <= 32'hF; ConIn <= 0; 
					end
					
					
					// check brnz
					5'b00011 : begin	
						BusMuxOut <= 32'hFFFF; 	// takes branch 
						//BusMuxOut <= 32'h0;		// does not take branch
						IRout <= 32'h98080000; ConIn <= 1;
						
						
						#15 BusMuxOut <= 32'hF0000000; IRout <= 32'h0; ConIn <= 0;
					end
					
					
					// check brpl
					5'b00100 : begin	
						//BusMuxOut <= 32'hFFFF;				// takes branch 
						BusMuxOut <= 32'hFFFF0000;			// does not take branch
						IRout <= 32'h98100000; ConIn <= 1;
						
						
						#15 BusMuxOut <= 32'hFFFF; 	IRout <= 32'h98100000; ConIn <= 0;
					end
					
					
					// check brmi
					5'b00101 : begin
						BusMuxOut <= 32'hFFFF0000; 	// takes branch
						//BusMuxOut <= 32'hFFFF;			// does not take branch
						IRout <= 32'h98180000; ConIn <= 1;
						
						
						#15 ConIn <= 0;
					end
					
			endcase
			
	end
	
endmodule
