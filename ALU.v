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

integer i; // temp int used for for loop
integer j;

// special values used for ADD
reg [31:0] C;
reg [32:0] ADD_sum;
reg ADD_cout;
reg [31:0] FAs, FAc, RCAc;

// special values for SUB
reg [31:0] SUB_temp;

// special values for DIV
reg [31:0] Q;
reg [31:0] M;

// special values used for MUL
reg [63:0] MUL_X;

initial begin
	C = 32'b0; 
	ADD_sum = 32'b0;
	ADD_cout = 1'b0;
	Q = 32'b0;
	M = 32'b0;
	MUL_X = 64'b0;
	ALU_Result = 64'b0;
end

	
always @ (*) begin
			
		
		
		/* --------ADD CODE--------*/
		if (ADD) begin
			// some addition algorithm here
			// make add a function
			C = 32'b0;

			for(j = 0; j < 32; j = j + 1) begin
				FAs[j] = A[j] ^ B[j] ^ C[j];
				FAc[j] = (A[j] & B[j]) | (C[j] & B[j]) | (C[j] & A[j]);
			end

			ADD_sum[0] = FAs[0] ^ 1'b0 ^ 1'b0;
			RCAc[0] = (FAs[0] & 1'b0) | (1'b0 & 1'b0) | (1'b0 & FAs[0]);

			for(i = 1; i < 32; i = i + 1) begin
				ADD_sum[i] = FAs[i] ^ FAc[i-1] ^ RCAc[i-1];
				RCAc[i] = (FAs[i] & FAc[i-1]) | (RCAc[i-1] & FAc[i-1]) | (RCAc[i-1] & FAs[i]);
			end

			ADD_sum[32] = 1'b0 ^ FAc[31] ^ RCAc[31];
			ADD_cout = (1'b0 & FAc[31]) | (RCAc[31] & FAc[31]) | (RCAc[31] & 1'b0);
			
			ALU_Result = ADD_sum[31:0];
			
		end
		
		
		/* --------SUB CODE--------*/
		else if (SUB) begin
			// Flip the second operand
			SUB_temp = ~B;
			SUB_temp = SUB_temp + 1;

			// Execute add code
			C = 32'b0;

			for(j = 0; j < 32; j = j + 1) begin
				FAs[j] = A[j] ^ SUB_temp[j] ^ C[j];
				FAc[j] = (A[j] & SUB_temp[j]) | (C[j] & SUB_temp[j]) | (C[j] & A[j]);
			end

			ADD_sum[0] = FAs[0] ^ 1'b0 ^ 1'b0;
			RCAc[0] = (FAs[0] & 1'b0) | (1'b0 & 1'b0) | (1'b0 & FAs[0]);

			for(i = 1; i < 32; i = i + 1) begin
				ADD_sum[i] = FAs[i] ^ FAc[i-1] ^ RCAc[i-1];
				RCAc[i] = (FAs[i] & FAc[i-1]) | (RCAc[i-1] & FAc[i-1]) | (RCAc[i-1] & FAs[i]);
			end

			ADD_sum[32] = 1'b0 ^ FAc[31] ^ RCAc[31];
			ADD_cout = (1'b0 & FAc[31]) | (RCAc[31] & FAc[31]) | (RCAc[31] & 1'b0);
			
			ALU_Result = ADD_sum[31:0];
		end
		
		/* --------MUL CODE--------*/
		else if (MUL) begin
			
			ALU_Result = 64'b0;
			
			// let MUL_X = A
			MUL_X[31:0] = A;
			if (A[31]) MUL_X[63:32] = 32'hFFFFFFFF; // sign extends if A is negative
			
			
			
			$display("Checking first two bits for multiplication");
			// use booth algorithm with bit-pair recoding
			// A is multiplicand(M), B is multiplier(Q)
			
			// init case for first 2 bits of Q
			case (B[1:0])
				2'b00 : begin
					// 3 bits to be considered with right padded 0 == 000;
					// bit-pair recoded result (BPRR) = 0
					// do nothing
					$display("Recoded B[1:0] to 0");
				end
				
			    2'b01 :	begin
					// 3 bits to be considered with right padded 0 == 010;
					// bit-pair recoded result (BPRR) = +1
					ALU_Result = ALU_Result + MUL_X;
					$display("Recoded B[1:0] to +1");
				end
				
			   2'b10 :	begin
					// 3 bits to be considered with right padded 0 == 100;
					// bit-pair recoded result (BPRR) = -2
					ALU_Result = ALU_Result - (MUL_X << 1);
					$display("Recoded B[1:0] to -2");
				end
				
			   2'b11 : begin
					// 3 bits to be considered with right padded 0 == 110;
					// bit-pair recoded result (BPRR) = -1
					ALU_Result = ALU_Result - MUL_X;
					$display("Recoded B[1:0] to -1");
				end
			endcase
			
			$display("ALU_Result = %b", ALU_Result);

			$display("Checking rest of bits for multiplication");

			// for loop to recode all other bits, 3 at a time
			// check if sign-extend works properly
			for(i = 1; i < 30; i = i + 2) begin // just trust it
				
				case (B[i+:3]) // some fancing syntax for selecting 3 bits starting at index i
					3'b000 : begin
						// 3 bits to be considered with right padded 0 == 000
						// bit-pair recoded result (BPRR) = 0
						// do nothing
						$display("Recoded to 0");
					end
					
					3'b001 : begin
						// 3 bits to be considered with right padded 0 == 001
						// bit-pair recoded result (BPRR) = +1
						ALU_Result = ALU_Result + (MUL_X << (i+1));
						$display("Recoded to +1");
					end
					
					3'b010 : begin
						// 3 bits to be considered with right padded 0 == 010
						// bit-pair recoded result (BPRR) = +1
						ALU_Result = ALU_Result + (MUL_X << (i+1));
						$display("Recoded to +1");
					end
					
					3'b011 : begin
						// 3 bits to be considered with right padded 0 == 011
						// bit-pair recoded result (BPRR) = +2
						ALU_Result = ALU_Result + (MUL_X << (i+2));
						$display("Recoded to +2");
					end
					
					3'b100 : begin
						// 3 bits to be considered with right padded 0 == 100
						// bit-pair recoded result (BPRR) = -2
						ALU_Result = ALU_Result - (MUL_X << (i+2));
						$display("Recoded to -2");
					end
					
					3'b101 : begin
						// 3 bits to be considered with right padded 0 == 101
						// bit-pair recoded result (BPRR) = -1
						ALU_Result = ALU_Result - (MUL_X << (i+1));
						$display("Recoded to -1");
					end
					
					3'b110 : begin
						// 3 bits to be considered with right padded 0 == 110
						// bit-pair recoded result (BPRR) = -1
						ALU_Result = ALU_Result - (MUL_X << (i+1));
						$display("Recoded to -1");
					end
					
					3'b111 : begin
						// 3 bits to be considered with right padded 0 == 111
						// bit-pair recoded result (BPRR) = 0
						// do nothing
						$display("Recoded to 0");
					end
				endcase
				
				$display("ALU_Result = %b, %h", ALU_Result, ALU_Result);
				
			end
		end
		
		
		/* --------DIV CODE--------*/
		else if (DIV) begin
			// use non-restoring division algorithm
			// assume A is dividend(Q), B is divisor(M)
			// use two separate registers for A and Q
			// start with DIV_A = 0, Q = input A
			
			// initialize DIV_A and Q values
			DIV_A = 33'b0;				// DIV_A register used as A register
			
			if(A[31]) begin			// check if Q needs to be negated bcz Q < 0
					Q = ~A; 				// put flipped bits into Q
					Q = Q + 1; 			// add 1 to complete negation
			end
			else begin 					// else case, no negation needed
					Q = A;				// place input directly into Q

			end
			
			// check is M is positive or negative
			if (B[31]) begin
				M = ~B;					// negate M as needed
				M = M + 1;
			end
			else begin
				M = B;					// place B input directly into M
				$display("M = %b", M);
				$display("B = %b", B);
			end
			
			
			// loop for DIV algorithm
			for (i = 0; i < 32; i = i + 1) begin
				// left shift ALU_Result (Q) and DIV_A (A)
				DIV_A = DIV_A << 1;				// SHL
				DIV_A[0] = Q[31];					// carry bit over from Q to A
				Q = Q << 1;							// SHL
				$display("DIV_A = %b, Q = %b", DIV_A, Q);
				
				// determine whether to add or subtract from DIV_A
				if (DIV_A[32]) begin 			// leftmost bit == 1, ADD
					DIV_A = DIV_A + M;
				end			
				else begin							// leftmost bit == 0, SUB
					DIV_A = DIV_A - M;			
				end
				
				// determine whether to right-pad Q with 1 or 0 after operating on DIV_A
				if (DIV_A[32]) begin				// leftmost bit == 1, pad w/ 0
					Q[0] = 1'b0;
				end
				else begin							// leftmost bit == 0, pad w/ 1
					Q[0] = 1'b1;		
				end
			end
			
			// check if remainder is negative, restore value as needed
			if (DIV_A[32]) begin
				$display("DIV_A_i = %b", DIV_A);
				DIV_A = DIV_A + M;
				$display("DIV_A_f = %b", DIV_A);
			end

			// DIVISION ALGORITHM COMPLETED AT THIS POINT
			
			// check to see if quotient needs to be negated bcz of possible negative inputs
			if (A[31] && (!B[31])) begin 					// case if only A is negative
				$display("Quotient flipped because A is negative");
				Q= ~Q; 											// flip bottom 32 bits of Q register
				Q = Q + 1; 										// add 1 to complete 2's comp
			end
			else if ((!A[31]) && B[31]) begin			// case if only B is negative
				$display("Quotient flipped because B is negative");
				Q = ~Q; 											// flip bottom 32 bits of Q register
				Q = Q + 1; 										// add 1 to complete 2's comp
			end
			// if both A and B are both +ve or both -ve don't matter
					
			ALU_Result[63:32] = DIV_A[31:0]; // store remainder in top 32 bits of ALU_Result
			ALU_Result[31:0] = Q[31:0];		// store quotient in bottom 32 bits of ALU_Result
		end
		
		
		/* --------AND CODE--------*/
		else if (AND) begin
			ALU_Result = A & B;
		end
		
		
		/* --------OR CODE--------*/
		else if (OR) begin
			ALU_Result = A | B;
		end
		
		
		/* --------SHR CODE--------*/
		else if (SHR) begin
			// SHR is same as divide by 2
			// note: if amount to be shifted >= 32, result is always 0
			ALU_Result = A >> B;
		end
		
		
		/* --------SHRA CODE--------*/
		else if (SHRA) begin
			// NOTE: if amount to be shifted >= 32, result is always 0? (check for case of max neg number)
			// can add if case with bit masking for this functionality
			ALU_Result = $signed(A) >>> B;
			// NOTE: '>>>' is the operator for arithmetic shifting, but A may need to initially be sign extended
		end
		
		
		/* --------SHL CODE--------*/
		else if (SHL) begin
			// NOTE: if amount to be shifted >= 32, result is always 0
			// can add if case with bit masking for this functionality
			ALU_Result = A << B;
		end
		
		
		/* --------ROR CODE--------*/
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
		
		
		/* --------ROL CODE--------*/
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
		
		
		/* --------NEG CODE--------*/
		else if (NEG) begin
			// do 2's complement operation
			ALU_Result = ~B; // flip bits
			ALU_Result = ALU_Result + 1; // add 1
		end
		
		
		/* --------NOT CODE--------*/
		else if (NOT) begin
			// flip bits (unsigned)
			ALU_Result = ~B; // '~' operator is used for flipping bits, '!' evaluates to either '0' or '1'
		end
		
		
		/* --------IncPC CODE--------*/
		else if (IncPC) begin
			ALU_Result = B + 1; // PC increments by 1 each time
		end
		
		else begin
			ALU_Result = ALU_Result; //do nothing
		end
	end
	
	// low 32 bits go to low reg, high 32 bits go to high reg
	assign Clow = ALU_Result[31:0];	
	assign Chigh = ALU_Result[63:32];

endmodule
