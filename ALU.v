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
reg [32:0] DIV_A; // temp 33 bit reg a for div

integer i; // temp int used for for loop
	
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
			// A is multiplicand(M), B is multiplier(Q)
			
			// init case for first 2 bits of Q
			case (B[1:0])
				2'b00 : begin
					// 3 bits to be considered with right padded 0 == 000;
					// bit-pair recoded result (BPRR) = 0
					// do nothing
				end
				
			      	2'b01 :	begin
					// 3 bits to be considered with right padded 0 == 010;
					// bit-pair recoded result (BPRR) = +1
					ALU_Result = ALU_Result + A;
				end
				
			      	2'b10 :	begin
					// 3 bits to be considered with right padded 0 == 100;
					// bit-pair recoded result (BPRR) = -2
					ALU_Result = ALU+Result - (A << 1);
				end
				
			      	2'b11 : begin
					// 3 bits to be considered with right padded 0 == 110;
					// bit-pair recoded result (BPRR) = -1
					ALU_Result = ALU_Result - A;
				end
			endcase

			// NOTE: Add code to update ALU_Result value from init case

			// for loop to recode all other bits, 3 at a time
			// check if sign-extend works properly
			for(i = 1; i < 30; i = i + 2) begin // just trust it
				case (B[i+:3]) // some fancing syntax for selecting 3 bits starting at index i
					3'b000 : begin
						// 3 bits to be considered with right padded 0 == 000
						// bit-pair recoded result (BPRR) = 0
						// do nothing
					end
					
					3'b001 : begin
						// 3 bits to be considered with right padded 0 == 001
						// bit-pair recoded result (BPRR) = +1
						ALU_Result = ALU_Result + (A << i)
					end
					
					3'b010 : begin
						// 3 bits to be considered with right padded 0 == 010
						// bit-pair recoded result (BPRR) = +1
						ALU_Result = ALU_Result + (A << i)
					end
					
					3'b011 : begin
						// 3 bits to be considered with right padded 0 == 011
						// bit-pair recoded result (BPRR) = +2
						ALU_Result = ALU_Result + (A << (i+1))
					end
					
					3'b100 : begin
						// 3 bits to be considered with right padded 0 == 100
						// bit-pair recoded result (BPRR) = -2
						ALU_Result = ALU_Result - (A << (i+1))
					end
					
					3'b101 : begin
						// 3 bits to be considered with right padded 0 == 101
						// bit-pair recoded result (BPRR) = -1
						ALU_Result = ALU_Result - (A << i)
					end
					
					3'b110 : begin
						// 3 bits to be considered with right padded 0 == 110
						// bit-pair recoded result (BPRR) = -1
						ALU_Result = ALU_Result - (A << i)
					end
					
					3'b111 : begin
						// 3 bits to be considered with right padded 0 == 111
						// bit-pair recoded result (BPRR) = 0
						// do nothing
					end
				endcase
			end
		end
		
		// div case
		else if (DIV) begin
			// use non-restoring division algorithm
			// assume A is divident(D), B is divisor(Q)
			// use two separate registers for A and Q
			// start with A = 0, Q = B
			// WIP
			// NOTE: Use new 33-bit DIV_A register to implement A register
			// new possible solution:
			// set bottom 32 bits to ALU_Result register = to Q
			// set DIV_A = 0
			// use for loop for non-restoring div algorithm
			// for (i = 0; i < 32; i = i + 1){
				// left shift ALU_Result (Q) and DIV_A (A)
				// DIV_A[0] = ALU_Result[32] // move bit over
				// determine whether to add or subtract D from DIV_A
				// if (DIV_A[32] == 1'b0){
					// DIV_A = DIV_A - D
				//}
				// else {
					// DIV_A = DIV_A + D
				//}
				// determine where to right-pad Q with 1 or 0 after operating on DIV_A
				// if (DIV_A[32] == 1'b0) {
					// ALU_Result[0] = 1
				// } 
				// else {
					// ALU_Result[0] = 0
				// }
 			//}
			// Result of division is stored in bottom 32 bits of ALU_Result reg
			// Remainder is stored in bottom 32 bits of DIV_A register
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
			ALU_Result = 32'hAAAAAAAA; // shows up in binary as 1010... for 32 bits, may help for debugging, otherwise meaningless
		end
	end
	// low 32 bits go to low reg, high 32 bits go to high reg
	assign Clow = ALU_Result[31:0];	
	assign Chigh = ALU_Result[63:32];

endmodule
