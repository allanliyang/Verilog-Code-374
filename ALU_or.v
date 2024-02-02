// logical OR operation for ALU
module ALU_or (

	input [31:0]A
	input [31:0]B
	input OR
	
	output wire [31:0]Zlowout
);

reg [31:0]Z;

always @ (*)
	begin
		if (OR) Z = A | B;
	end

assign Zlowout = z
endmodule