
`timescale 1ns/10ps

module MDR_tb();

reg clock, clear, MDRin, read;
reg [31:0] busdata, chipdata;
wire [31:0] busout;


MDR MDR(clear, clock, MDRin, read, busdata, chipdata, busout);

initial begin clock = 0; end
always #10 clock = ~clock;

always @ (posedge clock) begin

		chipdata <= 32'hAAAAAAAA;
		busdata <= 32'hFFFFFFFF;
		MDRin <= 1; read <= 1;
		#25 read <= 0;
		#25 clear <= 1;
		#50 clear <= 0;
end
endmodule	