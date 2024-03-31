
// all this tb does is simulate the clock signal

`timescale 1ns/10ps
module datapath_tb();

	reg clock, reset, stop;
	reg [31:0]InPortdata;
	
	// output from datapath
	wire [31:0]OutPortdata;
	
	
	Datapath DUT 	(clock, reset, stop,
						InPortdata,
						OutPortdata);
						
						
	initial begin 
		
		clock = 0; 
		InPortdata = 32'h80;
		
	end
	always #10 clock = ~clock;

endmodule
	