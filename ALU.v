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
wire [31:0] FAc, FAs, RCAc;
input [31:0] C;



integer i; // temp int used for for loop
	
always @ (*) begin
		// add case
		if (ADD) begin
			// some addition algorithm here
			// make add a function
			C = 32'b0;
			
			fulladder fa0(A[0], B[0], C[0], FAs[0], FAc[0]);
			fulladder fa1(A[1], B[1], C[1], FAs[1], FAc[1]);
			fulladder fa2(A[2], B[2], C[2], FAs[2], FAc[2]);
			fulladder fa3(A[3], B[3], C[3], FAs[3], FAc[3]);
			fulladder fa4(A[4], B[4], C[4], FAs[4], FAc[4]);
			fulladder fa5(A[5], B[5], C[5], FAs[5], FAc[5]);
			fulladder fa6(A[6], B[6], C[6], FAs[6], FAc[6]);
			fulladder fa7(A[7], B[7], C[7], FAs[7], FAc[7]);
			fulladder fa8(A[8], B[8], C[8], FAs[8], FAc[8]);
			fulladder fa9(A[9], B[9], C[9], FAs[9], FAc[9]);
			fulladder fa10(A[10], B[10], C[10], FAs[10], FAc[10]);
			fulladder fa11(A[11], B[11], C[11], FAs[11], FAc[11]);
			fulladder fa12(A[12], B[12], C[12], FAs[12], FAc[12]);
			fulladder fa13(A[13], B[13], C[13], FAs[13], FAc[13]);
			fulladder fa14(A[14], B[14], C[14], FAs[14], FAc[14]);
			fulladder fa15(A[15], B[15], C[15], FAs[15], FAc[15]);
			fulladder fa16(A[16], B[16], C[16], FAs[16], FAc[16]);
			fulladder fa17(A[17], B[17], C[17], FAs[17], FAc[17]);
			fulladder fa18(A[18], B[18], C[18], FAs[18], FAc[18]);
			fulladder fa19(A[19], B[19], C[19], FAs[19], FAc[19]);
			fulladder fa20(A[20], B[20], C[20], FAs[20], FAc[20]);
			fulladder fa21(A[21], B[21], C[21], FAs[21], FAc[21]);
			fulladder fa22(A[22], B[22], C[22], FAs[22], FAc[22]);
			fulladder fa23(A[23], B[23], C[23], FAs[23], FAc[23]);
			fulladder fa24(A[24], B[24], C[24], FAs[24], FAc[24]);
			fulladder fa25(A[25], B[25], C[25], FAs[25], FAc[25]);
			fulladder fa26(A[26], B[26], C[26], FAs[26], FAc[26]);
			fulladder fa27(A[27], B[27], C[27], FAs[27], FAc[27]);
			fulladder fa28(A[28], B[28], C[28], FAs[28], FAc[28]);
			fulladder fa29(A[29], B[29], C[29], FAs[29], FAc[29]);
			fulladder fa30(A[30], B[30], C[30], FAs[30], FAc[30]);
			fulladder fa31(A[31], B[31], C[31], FAs[31], FAc[31]);

			// Connect remaining full adder instances
			fulladder fa1_0(FAs[0], 1'b0, 1'b0, sum[0], RCAc[0]); // Connect the final stage full adder with carry-in 0
			fulladder fa1_1(FAs[1], FAc[0], RCAc[0], sum[1], RCAc[1]);
			fulladder fa1_2(FAs[2], FAc[1], RCAc[1], sum[2], RCAc[2]);
			fulladder fa1_3(FAs[3], FAc[2], RCAc[2], sum[3], RCAc[3]);
			fulladder fa1_4(FAs[4], FAc[3], RCAc[3], sum[4], RCAc[4]);
			fulladder fa1_5(FAs[5], FAc[4], RCAc[4], sum[5], RCAc[5]);
			fulladder fa1_6(FAs[6], FAc[5], RCAc[5], sum[6], RCAc[6]);
			fulladder fa1_7(FAs[7], FAc[6], RCAc[6], sum[7], RCAc[7]);
			fulladder fa1_8(FAs[8], FAc[7], RCAc[7], sum[8], RCAc[8]);
			fulladder fa1_9(FAs[9], FAc[8], RCAc[8], sum[9], RCAc[9]);
			fulladder fa1_10(FAs[10], FAc[9], RCAc[9], sum[10], RCAc[10]);
			fulladder fa1_11(FAs[11], FAc[10], RCAc[10], sum[11], RCAc[11]);
			fulladder fa1_12(FAs[12], FAc[11], RCAc[11], sum[12], RCAc[12]);
			fulladder fa1_13(FAs[13], FAc[12], RCAc[12], sum[13], RCAc[13]);
			fulladder fa1_14(FAs[14], FAc[13], RCAc[13], sum[14], RCAc[14]);
			fulladder fa1_15(FAs[15], FAc[14], RCAc[14], sum[15], RCAc[15]);
			fulladder fa1_16(FAs[16], FAc[15], RCAc[15], sum[16], RCAc[16]);
			fulladder fa1_17(FAs[17], FAc[16], RCAc[16], sum[17], RCAc[17]);
			fulladder fa1_18(FAs[18], FAc[17], RCAc[17], sum[18], RCAc[18]);
			fulladder fa1_19(FAs[19], FAc[18], RCAc[18], sum[19], RCAc[19]);
			fulladder fa1_20(FAs[20], FAc[19], RCAc[19], sum[20], RCAc[20]);
			fulladder fa1_21(FAs[21], FAc[20], RCAc[20], sum[21], RCAc[21]);
			fulladder fa1_22(FAs[22], FAc[21], RCAc[21], sum[22], RCAc[22]);
			fulladder fa1_23(FAs[23], FAc[22], RCAc[22], sum[23], RCAc[23]);
			fulladder fa1_24(FAs[24], FAc[23], RCAc[23], sum[24], RCAc[24]);
			fulladder fa1_25(FAs[25], FAc[24], RCAc[24], sum[25], RCAc[25]);
			fulladder fa1_26(FAs[26], FAc[25], RCAc[25], sum[26], RCAc[26]);
			fulladder fa1_27(FAs[27], FAc[26], RCAc[26], sum[27], RCAc[27]);
			fulladder fa1_28(FAs[28], FAc[27], RCAc[27], sum[28], RCAc[28]);
			fulladder fa1_29(FAs[29], FAc[28], RCAc[28], sum[29], RCAc[29]);
			fulladder fa1_30(FAs[30], FAc[29], RCAc[29], sum[30], RCAc[30]);
			fulladder fa1_31(FAs[31], FAc[30], RCAc[30], sum[31], RCAc[31]);
			fulladder fa1_32(1'b0, FAc[31], RCAc[31], sum[32], cout);
			ALU_Result = ADD_Sum[31:0];
			
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
