module MAR(
	input clear, clock, MARin,
	input [31:0]BusMuxOut,
	output wire [8:0]MARAddrOut 
); 

reg [8:0] q; 

always @ (posedge clock)
		begin
			if (clear) begin
				q <= 9'h0; //reset the register to 0
			end
			else if (MARin) begin
				q <= BusMuxOut[8:0];
			end
		end
	assign MARAddrOut = q;
endmodule

