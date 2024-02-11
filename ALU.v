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

reg [4:0] Rotate; // temp 5-bit value used for rotate 

reg [32:0] sum; // temp 33 bit reg a for div
integer cout; // temp 1 bit carry for add
reg [31:0] FAc, FAs, RCAc;
reg [31:0] C;



integer i; // temp int used for for loop
	
always @ (*) begin
		// add case
		if (ADD) begin
			// some addition algorithm here
			// make add a function
			C = 32'b0;

			for(j = 0; j < 32; j = j + 1) begin
				FAs[j] = A[j] ^ B[j] ^ C[j];
				FAc[j] = (A[j] & B[j]) | (C[j] & B[j]) | (C[j] & A[j]);
			end

			sum[0] = FAs[0] ^ 1'b0 ^ 1'b0;
			RCAc[0] = (FAs[0] & 1'b0) | (1'b0 & 1'b0) | (1'b0 & FAs[0]);

			for(i = 1; i < 32; i = i + 1) begin
				sum[i] = FAs[i] ^ FAc[i-1] ^ RCAc[i-1];
				RCAc[i] = (FAs[i] & FAc[i-1]) | (RCAc[i-1] & FAc[i-1]) | (RCAc[i-1] & FAs[i]);
			end

			sum[32] = 1'b0 ^ FAc[31] ^ RCAc[31];
			cout = (1'b0 & FAc[31]) | (RCAc[31] & FAc[31]) | (RCAc[31] & 1'b0);
			
			ALU_Result = sum[31:0];
			
		end
		
		// sub case
		else if (SUB) begin
			// Flip the second operand
			B = ~B + 1;

			// Execute add code
			C = 32'b0;

			for(j = 0; j < 32; j = j + 1) begin
				FAs[j] = A[j] ^ B[j] ^ C[j];
				FAc[j] = (A[j] & B[j]) | (C[j] & B[j]) | (C[j] & A[j]);
			end

			sum[0] = FAs[0] ^ 1'b0 ^ 1'b0;
			RCAc[0] = (FAs[0] & 1'b0) | (1'b0 & 1'b0) | (1'b0 & FAs[0]);

			for(i = 1; i < 32; i = i + 1) begin
				sum[i] = FAs[i] ^ FAc[i-1] ^ RCAc[i-1];
				RCAc[i] = (FAs[i] & FAc[i-1]) | (RCAc[i-1] & FAc[i-1]) | (RCAc[i-1] & FAs[i]);
			end

			sum[32] = 1'b0 ^ FAc[31] ^ RCAc[31];
			cout = (1'b0 & FAc[31]) | (RCAc[31] & FAc[31]) | (RCAc[31] & 1'b0);
			
			ALU_Result = sum[31:0];
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
					ALU_Result = ALU_Result - (A << 1);
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
						ALU_Result = ALU_Result + (A << i);
					end
					
					3'b010 : begin
						// 3 bits to be considered with right padded 0 == 010
						// bit-pair recoded result (BPRR) = +1
						ALU_Result = ALU_Result + (A << i);
					end
					
					3'b011 : begin
						// 3 bits to be considered with right padded 0 == 011
						// bit-pair recoded result (BPRR) = +2
						ALU_Result = ALU_Result + (A << (i+1));
					end
					
					3'b100 : begin
						// 3 bits to be considered with right padded 0 == 100
						// bit-pair recoded result (BPRR) = -2
						ALU_Result = ALU_Result - (A << (i+1));
					end
					
					3'b101 : begin
						// 3 bits to be considered with right padded 0 == 101
						// bit-pair recoded result (BPRR) = -1
						ALU_Result = ALU_Result - (A << i);
					end
					
					3'b110 : begin
						// 3 bits to be considered with right padded 0 == 110
						// bit-pair recoded result (BPRR) = -1
						ALU_Result = ALU_Result - (A << i);
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
			ALU_Result = $signed(A) >>> B;
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
			// since bits are recycled:
			// - ROR A by 32 is same as ROL A by 0
			// - ROR A by 33 is same as ROL A by 1, and so on
			Rotate = B % 32;
			
			case (Rotate)
				5'b00001 : ALU_Result[31:0] = {A[0], 		A[31:1]};
				5'b00010 : ALU_Result[31:0] = {A[1:0],		A[31:2]};
				5'b00011 : ALU_Result[31:0] = {A[2:0],		A[31:3]};
				5'b00100 : ALU_Result[31:0] = {A[3:0],		A[31:4]};
				5'b00101 : ALU_Result[31:0] = {A[4:0],		A[31:5]};
				5'b00110 : ALU_Result[31:0] = {A[5:0],		A[31:6]};
				5'b00111 : ALU_Result[31:0] = {A[6:0],		A[31:7]};
				5'b01000 : ALU_Result[31:0] = {A[7:0],		A[31:8]};
				5'b01001 : ALU_Result[31:0] = {A[8:0],		A[31:9]};
				5'b01010 : ALU_Result[31:0] = {A[9:0],		A[31:10]};
				5'b01011 : ALU_Result[31:0] = {A[10:0],	A[31:11]};
				5'b01100 : ALU_Result[31:0] = {A[11:0],	A[31:12]};
				5'b01101 : ALU_Result[31:0] = {A[12:0],	A[31:13]};
				5'b01110 : ALU_Result[31:0] = {A[13:0],	A[31:14]};
				5'b01111 : ALU_Result[31:0] = {A[14:0],	A[31:15]};
				5'b10000 : ALU_Result[31:0] = {A[15:0],	A[31:16]};
				5'b10001 : ALU_Result[31:0] = {A[16:0],	A[31:17]};
				5'b10010 : ALU_Result[31:0] = {A[17:0],	A[31:18]};
				5'b10011 : ALU_Result[31:0] = {A[18:0],	A[31:19]};
				5'b10100 : ALU_Result[31:0] = {A[19:0],	A[31:20]};
				5'b10101 : ALU_Result[31:0] = {A[20:0],	A[31:21]};
				5'b10110 : ALU_Result[31:0] = {A[21:0],	A[31:22]};
				5'b10111 : ALU_Result[31:0] = {A[22:0],	A[31:23]};
				5'b11000 : ALU_Result[31:0] = {A[23:0],	A[31:24]};
				5'b11001 : ALU_Result[31:0] = {A[24:0],	A[31:25]};
				5'b11010 : ALU_Result[31:0] = {A[25:0],	A[31:26]};
				5'b11011 : ALU_Result[31:0] = {A[26:0],	A[31:27]};
				5'b11100 : ALU_Result[31:0] = {A[27:0],	A[31:28]};
				5'b11101 : ALU_Result[31:0] = {A[28:0],	A[31:29]};
				5'b11110 : ALU_Result[31:0] = {A[29:0],	A[31:30]};
				5'b11111 : ALU_Result[31:0] = {A[30:0],	A[31:31]};
				default 	: ALU_Result[31:0] = A[31:0];
			endcase
		end
		
		// rol case
		else if (ROL) begin
			// since bits are recycled:
			// - ROL A by 32 is same as ROL A by 0
			// - ROL A by 33 is same as ROL A by 1, and so on
			Rotate = B % 32;
			
			case (B[4:0])
				5'b00001 : ALU_Result[31:0] = {A[30:0], 	A[31]};
				5'b00010 : ALU_Result[31:0] = {A[29:0], 	A[31:30]};
				5'b00011 : ALU_Result[31:0] = {A[28:0], 	A[31:29]};
				5'b00100 : ALU_Result[31:0] = {A[27:0], 	A[31:28]};
				5'b00101 : ALU_Result[31:0] = {A[26:0], 	A[31:27]};
				5'b00110 : ALU_Result[31:0] = {A[25:0], 	A[31:26]};
				5'b00111 : ALU_Result[31:0] = {A[24:0], 	A[31:25]};
				5'b01000 : ALU_Result[31:0] = {A[23:0], 	A[31:24]};
				5'b01001 : ALU_Result[31:0] = {A[22:0], 	A[31:23]};
				5'b01010 : ALU_Result[31:0] = {A[21:0], 	A[31:22]};
				5'b01011 : ALU_Result[31:0] = {A[20:0], 	A[31:21]};
				5'b01100 : ALU_Result[31:0] = {A[19:0], 	A[31:20]};
				5'b01101 : ALU_Result[31:0] = {A[18:0], 	A[31:19]};
				5'b01110 : ALU_Result[31:0] = {A[17:0], 	A[31:18]};
				5'b01111 : ALU_Result[31:0] = {A[16:0], 	A[31:17]};
				5'b10000 : ALU_Result[31:0] = {A[15:0],	A[31:16]};
				5'b10001 : ALU_Result[31:0] = {A[14:0],	A[31:15]};
				5'b10010 : ALU_Result[31:0] = {A[13:0], 	A[31:14]};
				5'b10011 : ALU_Result[31:0] = {A[12:0], 	A[31:13]};
				5'b10100 : ALU_Result[31:0] = {A[11:0], 	A[31:12]};
				5'b10101 : ALU_Result[31:0] = {A[10:0], 	A[31:11]};
				5'b10110 : ALU_Result[31:0] = {A[9:0], 	A[31:10]};
				5'b10111 : ALU_Result[31:0] = {A[8:0], 	A[31:9]};
				5'b11000 : ALU_Result[31:0] = {A[7:0], 	A[31:8]};
				5'b11001 : ALU_Result[31:0] = {A[6:0], 	A[31:7]};
				5'b11010 : ALU_Result[31:0] = {A[5:0], 	A[31:6]};
				5'b11011 : ALU_Result[31:0] = {A[4:0], 	A[31:5]};
				5'b11100 : ALU_Result[31:0] = {A[3:0], 	A[31:4]};
				5'b11101 : ALU_Result[31:0] = {A[2:0], 	A[31:3]};
				5'b11110 : ALU_Result[31:0] = {A[1:0], 	A[31:2]};
				5'b11111 : ALU_Result[31:0] = {A[0], 		A[31:1]};
				default 	: ALU_Result[31:0] = A[31:0];
			endcase
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
