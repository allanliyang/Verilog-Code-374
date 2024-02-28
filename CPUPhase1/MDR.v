// only used for MDR register due to extra inputs


// shits fucked, Mdatain and Bus values aren't going into q
// clock, clear, MDRin, read, BusMuxOut, Mdatain, are all correctly seen by MDR as seem from simulation
// works perfectly fine in MDR_tb, broken asf in datapath_tb


module MDR (
	
	input clear, clock, MDRin, read, // extra signal for MDMux select, see Phase 1 documentation
	input [31:0]BusMuxOut,
	input [31:0]Mdatain, 				//MDR register has extra Mdatain input
	output wire [31:0]BusMuxIn
);

reg [31:0]q;

initial q = 32'h00000000;

always @ (posedge clock)
		begin
			if (MDRin) begin
				if (read) q <= Mdatain;
				else q <= BusMuxOut;
			end
			else if (clear) begin
				q <= 32'h0000000;
			end			
		end
	assign BusMuxIn = q;
endmodule
