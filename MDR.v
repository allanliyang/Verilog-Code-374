module MDR #(DATA_WDITH_IN = 32, DATA_WIDTH_OUT = 32, INIT = 8'H0000)(
	input clear, clock, enable, read,
	input [DATA_WIDTH_IN-1:0]BusMuxOut, Mdatain
	output wire [DATA_WIDTH_OUT-1:0]BusMuxIn
	
);

reg [DATA_WIDTH_IN-1:0]q;

initial q = INIT;

always @ (posedge clock)
		begin
			if (clear) begin
				q <= {DATA_WIDTH_IN{1'b0}};
			end
			else if (enable) begin
				if(read) q <= Mdatain;
				else q <= BusMuxOut;
			end
		end
	assign BusMuxIn = q[DATA_WIDTH_OUT-1:0];
endmodule