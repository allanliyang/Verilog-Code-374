// only used for MDR register due to extra inputs

module MDR #(DATA_WIDTH_IN = 32, DATA_WIDTH_OUT = 32, INIT = 8'h00000000)(
	
	input clear, clock, MDRin,
	input [DATA_WIDTH_IN-1:0]BusMuxOut, Mdatain, //MDR register has extra Mdatain input
	input read,												// extra signal for MDMux select, see Phase 1 documentation
	
	output wire [DATA_WIDTH_OUT-1:0]BusMuxIn 		// '02/01', output to memory chip should prob also be here 
);

reg [DATA_WIDTH_IN-1:0]q;

initial q = INIT;

always @ (posedge clock)
		begin
			if (clear) begin
				q <= {DATA_WIDTH_IN{1'b0}};
			end
			else if (MDRin) begin
				if(read) q <= Mdatain; //assuming read=1 means read from mem chip
				else q <= BusMuxOut; // otherwise set q to data from bus
			end
		end
		
	assign BusMuxIn = q[DATA_WIDTH_OUT-1:0];
endmodule
