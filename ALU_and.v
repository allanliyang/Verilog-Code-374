// logical AND operation for ALU
module ALU_and (

	input [31:0]A
	input [31:0]B
	input AND
	
	output wire [31:0]Zlowout
);

reg [31:0]Z;

always @ (*)
	begin
		if (ADD) Z = A & B;
	end

assign Zlowout = z
endmodule
