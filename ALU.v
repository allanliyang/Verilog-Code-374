// module for Phase 1 ALU
// this file contains all operations required in Phase 1

/* op code for Phase 1 ALU operations from CPU Documentation in 5-bit binary
	ADD: 00011
	SUB: 00100
	MUL: 01111
	DIV: 10000
	AND: 01010
	OR: 01011
	SHR: 00101
	SHRA: 00110
	SHL: 00111
	ROR: 01000
	ROL: 01001
	NEG: 10001
	NOT: 10010
*/

module ALU (
	input [31:0] A, B,
	input ADD, SUB, MUL, DIV,
			AND, OR, SHR, SHRA,
			SHL, ROR, ROL, NEG, NOT, IncPC,
	
	output [31:0]Chigh, Clow //hi reg used only for mul and div
);

reg [63:0] ALU_Result; // 64 bit temp register to hold result of operations



// CONSIDER USING FUNCTIONS FOR MORE COMPLEX OPERATION TO IMPROVE READABILITY
// NOTE: Check how the IncPC signal is supposed to work
always @ (*) begin
		// add case
		if (ADD) begin
			// some addition algorithm here
			
		end
		
		// sub case
		else if (SUB) begin
			// maybe same as add but negate the appropriate value first
		end
		
		// mul case
		else if (MUL) begin
			// booth algorithm with bit-pair recoding
			// use CSA for summands
		end
		
		// div case
		else if (DIV) begin
			// use non-restoring division algorithm
				// implement with for loop the length
		end
		
		// and case
		else if (AND) begin
			ALU_Result = A & B;
		end
		
		// or case
		else if (OR) begin
			ALU_Result = A | B;
		end
		
		// shr  case
		else if (SHR) begin
			// SHR is same as divide by 2
			// note: if amount to be shifted >= 32, result is always 0
			// helpful code: https://kaneriadhaval.blogspot.com/2014/02/32-bit-barrel-shifter-in-verilog.html
			ALU_Result = A >> B;
		end
		
		// shra case
		else if (SHRA) begin
			// NOTE: if amount to be shifted >= 32, result is always 0
			// can add if case with bit masking for this functionality 
			ALU_Result = A >>> B;
			// NOTE: '>>>' is the operator for arithmetic shifting, but A may need to initially be sign extended
		end
		
		// shl case
		else if (SHL) begin
			// NOTE: if amount to be shifted >= 32, result is always 0
			// can add if case with bit masking for this functionality
			ALU_Result = A << B;
		end
		
		// ror case
		else if (ROR) begin
			// maybe use a for loop to shift right and move fallen bits to front
		end
		
		// rol case
		else if (ROL) begin
			// maybe use a for loop to shift left and move fallen bits to back
		end
		
		// neg case
		else if (NEG) begin
			// do 2's complement operation
			ALU_Result = ~B; // flip bits
			ALU_Result = ALU_Result + 1; // add 1
		end
		
		// not case
		else if (NOT) begin
			// flip bits (unsigned)
			ALU_Result = ~B; // '~' operator is used for flipping bits, '!' evaluates to either '0' or '1'
		end
		
		else if (IncPC) begin
			ALU_Result = B + 1; // PC increments by 1 each time
		end
		
		else begin
			ALU_Result = 8'hCCCCCCCC // shows up in binary as 1010... for 32 bits, may help for debugging, otherwise meaningless
		end
	end
	// low 32 bits go to low reg, high 32 bits go to high reg
	assign Clow = ALU_Result[31:0];	
	assign Chigh = ALU_Result[63:32];

endmodule
