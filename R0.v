// only used for R0 due to special BAout input

module R0 (

	input clear, clock, enable, BAout,
	input [31:0]BusMuxOut,
	output wire [31:0]BusMuxIn
);

reg [31:0]q;
reg [31:0]temp;

initial begin
	q = 32'h00000000;
	temp = 32'h00000000;	// temp register to hold result of AND with BAout so contents of q don't chang
end

always @ (posedge clock) 
		begin
			
			if (clear) begin
				q <= 32'h00000000;
			end
			else if (enable) begin
				q <= BusMuxOut;
			end
			
			if (BAout) temp <= 32'h00000000; // write zeros if BAout == 1
			else temp <= q;						// write q is BAout == 0
	
		end

	assign BusMuxIn = temp;
		
endmodule
