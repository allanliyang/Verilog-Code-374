module InPort (
	
	input clear, clock,
	input [31:0]InputUnit,
	output wire [31:0]BusMuxInInPort
);

reg [31:0]q;


initial q = 32'h00000000;

always @ (posedge clock) begin
			
			if (clear) begin
				q <= 32'h00000000;			
			end
			else begin
				q = InputUnit;
			end
	end

	assign BusMuxInInPort = q;

endmodule
