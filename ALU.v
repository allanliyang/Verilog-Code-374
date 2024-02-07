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


always @ (*) begin
		// add case
		if (ADD) begin
			// some addition algorithm here
			// make add a function
			
		end
		
		// sub case
		else if (SUB) begin
			// maybe same as add but negate the appropriate value first
			// possible solution:
			// use addition function from above but negate appropriate parameters first
		end
		
		// mul case
		else if (MUL) begin
			// use booth algorithm with bit-pair recoding
			// use CSA for summands?
			// WIP
			// A is multiplicand(M), B is multiplier(Q)
			// possible solution:
			// clear result reg
			// for loop that start at index 0, ends at index 31, increments by 2 each time {
				// consider 3 digits at time (other than init 2 bits, use separate case)
				// use function to determine bit-pair recoded result
				// store result of function into 3-bit 2's complement register
				// based on value in 3-bit reg, (add or subtract (left-shifted M by index)) from ALU_Result
				// eg:
				// case (3-bit)
				// 3'b000 : ALU_Result = ALU_Result; // do nothing
				// 3'b001 : ALU_Result = ALU_Result + (A << index); // 001 = +1, left shift A to index and add to ALU_Result
				// 3'b101 : ALU_Result = ALU_Result - (A << index) - (A << (index + 1)); 
				// ^^: 101 = -3, left shift A to index and subtract from ALU_Result(sub A), then also subtract A left shifted by index plus 1 (sub 2A)
				// ^^: total sub 3A
				// and so on for other cases
				// maybe use a function for repetitive code
			//}
				
		end
		
		// div case
		else if (DIV) begin
			// use non-restoring division algorithm
			// assume A is divident(D), B is divisor(Q)
			// use two separate registers for A and Q
			// start with A = 0, Q = B
			// WIP
			// possible solution:
			// clear result reg
			// implement with for loop that ends at 31 (for 32-bit value){
				// shift A and Q left by 1, replace A[0] with Q[n]
				// if A([n] == 1) then A = A+M
				// else A = A-M
				// if (A[n] == 1) then Q[0] = 0
				// else Q[0] = 1
			// }
			// QUESTION: which registers to use for A and Q registers?
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
			// NOTE: if amount to be shifted >= 32, result is always 0? (check for case of max neg number)
			// can add if case with bit masking for this functionality
			// WIP
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
			// WIP

			// rotate by 32 is same as rotate by 0 (no action)
			// rotating by more than 32 is pointless work, ie ROR 33 is as ROR 1, etc...
			// possible solution:
				// modulus by 32
				// check if zero, else rotate amount of mod result
		end
		
		// rol case
		else if (ROL) begin
			// maybe use a for loop to shift left and move fallen bits to back
			// WIP
			// possible solution: same thought process as ROR instruction
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
