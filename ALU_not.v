module ALU_not (
	input [31:0]A
	input [31:0]B
	input NOT
	
	output wire [31:0]Z
);

reg [31:0]Z;

always @ (*)
	begin
		if (NOT) 
