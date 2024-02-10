module Register32bit #(parameter DATA_WIDTH_IN = 32, DATA_WIDTH_OUT = 32, INIT = 8'h00000000)(
	input clear, clock, enable,
	input [31:0]BusMuxOut,
	output wire [DATA_WIDTH_OUT-1:0]BusMuxIn
);

reg [31:0]q;

initial q = INIT;

always @ (posedge clock)
		begin
			if (clear) begin
				q <= 32'h00000000;
			end
			else if (enable) begin
				q <= BusMuxOut;
			end
		end
	assign BusMuxIn = q[31:0];
endmodule
