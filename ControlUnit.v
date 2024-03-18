
`timescale 1ns/10ps
module ControlUnit (

	input clock, reset, stop, ConFFQ,
	input [31:0] IR,
	// no other input for this control unit, i.e. no interrupt functionality
	
	// use output regs because they can be assigned values inside of always statements
	output reg run, clear,
	output reg MEMread, MEMwrite,
	output reg Rin, Rout, BAout, Gra, Grb, Grc,

	
	// ALU control signals
	output reg ADD, SUB, MUL, DIV,
	output reg AND, OR, 
	output reg SHR, SHRA, SHL,
	output reg ROR, ROL,
	output reg NEG, NOT,
	output reg IncPC,
	
	// Specialty register controls
	output reg PCin, PCout, IRin,
	output reg MDRin, MDRout, MARin,
	output reg Zhighin, Zlowin, Zhighout, Zlowout,
	output reg HIin, LOin, HIout, LOout,
	output reg CSEout,
	output reg Yin,
	output reg ConIn,
	output reg OutPortin, InPortout 

	// NOTE: Check if all signals have been added
);



	// definitions for various states and control sequences
				
					// reset and global T0-T2
	parameter 	reset_state = 8'b00000000, T0 = 8'b00000001, T1 = 8'b00000010, T2 = 8'b00000011,
					
					// load and store
					LD_T3  = 8'b00000011, 	LD_T4  = 8'b00000100, 	LD_T5  = 8'b00000101, 	LD_T6 = 8'b00000110, LD_T7 = 8'b00000111,
					LDI_T3 = 8'b00001011, 	LDI_T4 = 8'b00001100, 	LDI_T5 = 8'b00001101,
					ST_T3  = 8'b00010011, 	ST_T4  = 8'b00010100, 	ST_T5  = 8'b00010101, 	ST_T6 = 8'b00010110,
				
					// ALU operations
					ADD_T3  = 8'b00011011, 	ADD_T4  = 8'b00011100, 	ADD_T5  = 8'b00011101,
					ADDI_T3 = 8'b01100011, 	ADDI_T4 = 8'b01100100, 	ADDI_T5 = 8'b01100101,
					SUB_T3  = 8'b00100011, 	SUB_T4  = 8'b00100100, 	SUB_T5  = 8'b00100101,
					MUL_T3  = 8'b01111011, 	MUL_T4  = 8'b01111100, 	MUL_T5  = 8'b01111101, 	MUL_T6 = 8'b01111110,
					DIV_T3  = 8'b10000011, 	DIV_T4  = 8'b10000100, 	DIV_T5  = 8'b10000101, 	DIV_T6 = 8'b10000110,
					AND_T3  = 8'b01010011, 	AND_T4  = 8'b01010100, 	AND_T5  = 8'b01010101,
					ANDI_T3 = 8'b01101011, 	ANDI_T4 = 8'b01101100, 	ANDI_T5 = 8'b01101101,
					OR_T3   = 8'b01011011, 	OR_T4   = 8'b01011100,  OR_T5   = 8'b01011110,
					ORI_T3  = 8'b01110011, 	ORI_T4  = 8'b01110100, 	ORI_T5  = 8'b01110110,
					SHR_T3  = 8'b00101011, 	SHR_T4  = 8'b00101100, 	SHR_T5  = 8'b00101110,
					SHRA_T3 = 8'b00110011, 	SHRA_T4 = 8'b00110100, 	SHRA_T5 = 8'b00110110,
					SHL_T3  = 8'b00111011, 	SHL_T4  = 8'b00111100, 	SHL_T5  = 8'b00111110,
					ROR_T3  = 8'b01000011, 	ROR_T4  = 8'b01000100, 	ROR_T5  = 8'b01000110,
					ROL_T3  = 8'b01001011, 	ROL_T4  = 8'b01001100, 	ROL_T5  = 8'b01001110,
					NEG_T3  = 8'b10001011, 	NEG_T4  = 8'b10001100,
					NOT_T3  = 8'b10010011, 	NOT_T4  = 8'b10010100,
					
					// branch instruction
					BR_T3 = 8'b10011011, 	BR_T4 = 8'b10011100, 	BR_T5 = 8'b10011101, 	BR_T6 = 8'b10011110,
					
					// jump instructions
					JR_T3 = 8'b10100011,
					JAL_T3 = 8'b10101011, 	JAL_T4 = 8'b10101100,
					
					//in/out and mfhi/lo
					IN_T3   = 8'b10110011, 	IN_T4 = 8'b10110100,
					OUT_T3  = 8'b10111011,
					MFHI_T3 = 8'b11000011,
					MFLO_T3 = 8'b11001011,

					// misc.
					// NOTE: Check control sequences for nop and halt
					NOP_T3  = 8'b11010011,
					HALT_T3 = 8'b11011011;

					
	reg [7:0]present_state = reset_state;
	
	
					
	always @ (posedge clock, posedge reset) begin
		
		if (run == 1'b1) begin // only change state if program is supposed to be running
			
			if (reset == 1'b1) begin // check for reset case
				present_state = reset_state;
			end
		
			else begin // check other cases
			
				case (present_state)
					reset_state : 	present_state = T0;
					T0				:	present_state = T1;
					T1				:	present_state = T2;
					T2 : begin
						
						case (IR[31:27]) 
							
							5'b00000 : present_state = LD_T3;
							5'b00001 : present_state = LDI_T3;
							5'b00010 : present_state = ST_T3;
							
							// ALU
							5'b00011 : present_state = ADD_T3;
							5'b00100 : present_state = SUB_T3;
							5'b00101 : present_state = SHR_T3;
							5'b00110 : present_state = SHRA_T3;
							5'b00111 : present_state = SHL_T3;
							5'b01000 : present_state = ROR_T3;
							5'b01001 : present_state = ROL_T3;
							5'b01010 : present_state = AND_T3;
							5'b01011 : present_state = OR_T3;
							// immediates
							5'b01100 : present_state = ADDI_T3;
							5'b01101 : present_state = ANDI_T3;
							5'b01110 : present_state = ORI_T3;
							// mul/div and neg/not
							5'b01111 : present_state = MUL_T3;
							5'b10000 : present_state = DIV_T3;
							5'b10001 : present_state = NEG_T3;
							5'b10010 : present_state = NOT_T3;
							
							// branch
							5'b10011 : present_state = BR_T3;
							
							// jump
							5'b10100 : present_state = JR_T3;
							5'b10101 : present_state = JAL_T3;
							
							// in/out and mfhi/lo
							5'b10110 : present_state = IN_T3;
							5'b10111 : present_state = OUT_T3;
							5'b11000 : present_state = MFHI_T3;
							5'b11001 : present_state = MFLO_T3;
							
							// misc.
							5'b11010 : present_state = NOP_T3;
							5'b11011 : present_state = HALT_T3;
						
						endcase
					end
				
					// load and store
					LD_T3 : present_state = LD_T4;
					LD_T4 : present_state = LD_T5;
					LD_T5 : present_state = LD_T6;
					LD_T6 : present_state = LD_T7;
					LD_T7 : present_state = T0;
				
					LDI_T3 : present_state = LDI_T4;
					LDI_T4 : present_state = LDI_T5;
					LDI_T5 : present_state = T0;
					
					ST_T3 : present_state = ST_T4;
					ST_T4 : present_state = ST_T5;
					ST_T5 : present_state = ST_T6;
					ST_T6 : present_state = T0;
					
					// ALU
					ADD_T3 : present_state = ADD_T4;
					ADD_T4 : present_state = ADD_T5;
					ADD_T5 : present_state = T0;
					
					ADDI_T3 : present_state = ADDI_T4;
					ADDI_T4 : present_state = ADDI_T5;
					ADDI_T5 : present_state = T0;
					
					SUB_T3 : present_state = SUB_T4;
					SUB_T4 : present_state = SUB_T5;
					SUB_T5 : present_state = T0;
					
					MUL_T3 : present_state = MUL_T4;
					MUL_T4 : present_state = MUL_T5;
					MUL_T5 : present_state = MUL_T6;
					MUL_T6 : present_state = T0;
					
					DIV_T3 : present_state = DIV_T4;
					DIV_T4 : present_state = DIV_T5;
					DIV_T5 : present_state = DIV_T6;
					DIV_T6 : present_state = T0;
					
					AND_T3 : present_state = AND_T4;
					AND_T4 : present_state = AND_T5;
					AND_T5 : present_state = T0;
					
					ANDI_T3 : present_state = ANDI_T4;
					ANDI_T4 : present_state = ANDI_T5;
					ANDI_T5 : present_state = T0;
					
					OR_T3 : present_state = OR_T4;
					OR_T4 : present_state = OR_T5;
					OR_T5 : present_state = T0;
					
					ORI_T3 : present_state = ORI_T4;
					ORI_T4 : present_state = ORI_T5;
					ORI_T5 : present_state = T0;
					
					SHR_T3 : present_state = SHR_T4;
					SHR_T4 : present_state = SHR_T5;
					SHR_T5 : present_state = T0;
					
					SHRA_T3 : present_state = SHRA_T4;
					SHRA_T4 : present_state = SHRA_T5;
					SHRA_T5 : present_state = T0;
					
					SHL_T3 : present_state = SHL_T4;
					SHL_T4 : present_state = SHL_T5;
					SHL_T5 : present_state = T0;
					
					ROR_T3 : present_state = ROR_T4;
					ROR_T4 : present_state = ROR_T5;
					ROR_T5 : present_state = T0;
					
					ROL_T3 : present_state = ROL_T4;
					ROL_T4 : present_state = ROL_T5;
					ROL_T5 : present_state = T0;
					
					NEG_T3 : present_state = NEG_T4;
					NEG_T4 : present_state = T0;
					
					NOT_T3 : present_state = NOT_T4;
					NOT_T3 : present_state = T0;
					
					// branch
					BR_T3 : present_state = BR_T4;
					BR_T4 : present_state = BR_T5;
					BR_T5 : present_state = BR_T6;
					BR_T6 : present_state = T0;
					
					// jump
					JR_T3 : present_state = T0;
					
					JAL_T3 : present_state = JAL_T4;
					JAL_T4 : present_state = T0;
					
					// in/out and mfhi/lo
					IN_T3 : present_state = IN_T4;
					IN_T4 : present_state = T0;
					
					OUT_T3 : present_state = T0;
					
					MFHI_T3 : present_state = T0;
					MFLO_T3 : present_state = T0;
					
					// misc.
					NOP_T3  : present_state = T0; 
					HALT_T3 : present_state = reset_state;// CHECK WHAT TO DO HERE
					
				endcase
			end
		end
	end
	
	
	
	always @ (present_state) begin
	
			case (present_state) 
				
				reset_state : begin
					// initially need to be set to 1
					clear <= 1; run <= 1;
					
					// all others signals get reset to 0
					MEMread <= 0; MEMwrite <= 0;
					Rin <= 0; Rout <= 0; BAout <= 0; Gra <= 0; Grb <= 0; Grc <= 0;
					
					// ALU control signals
					ADD <= 0; SUB <= 0; MUL <= 0; DIV <= 0;
					AND <= 0; OR<= 0;
					SHR <= 0; SHRA <= 0; SHL <= 0;
					ROR <= 0; ROL <= 0;
					NEG <= 0; NOT <= 0;
					IncPC <= 0;
					
					// specialty register control signals
					PCin <= 0; PCout <= 0; IRin <= 0;
					MDRin <= 0; MDRout <= 0; MARin <= 0; 
					Zhighin <= 0; Zlowin <= 0; Zhighout <= 0; Zlowout <= 0;
					HIin <= 0; LOin <= 0; HIout <= 0; LOout <= 0;
					CSEout <= 0;
					Yin <= 0;
					ConIn <= 0;
					OutPortin <= 0; InPortout <= 0;
					
					#15 clear <= 0;
					
				end
				
				T0 : begin
					PCout <= 1; MARin <= 1; IncPC <= 1;
					#15 PCout <= 0; MARin <= 0; IncPC <= 0; Zlowin <= 0;
				end
				
				T1 : begin
					Zlowout <= 1; PCin <= 1; MEMread <= 1; MDRin <= 1;
					#15 Zlowout <= 0; PCin <= 0; MEMread <= 0; MDRin <= 0;
				end
				
				T2 : begin
					MDRout <= 1; IRin <= 1;
					#15 MDRout <= 0; IRin <= 0;
				end
				
				
				// load and store instructions
				// LD
				LD_T3 : begin
				
				
				end
				
				LD_T4 : begin
				
				
				end
				
				LD_T5 : begin
				
				
				end
				
				LD_T6 : begin
				
				
				end
				
				LD_T7 : begin
				
				
				end
				
				// LDI
				LDI_T3 : begin
				
				
				end
				
				LDI_T4 : begin
				
				
				end
				
				LDI_T5 : begin
				
				
				end
				
				// ST
				ST_T3 : begin
				
				
				end
				
				ST_T4 : begin
				
				
				end
				
				ST_T5 : begin
				
				
				end
				
				ST_T6 : begin
				
				
				end
				
				
				// ALU instructions
				// ADD
				ADD_T3 : begin 
				
				
				end
				
				ADD_T4 : begin 
				
				
				end
				
				ADD_T5 : begin 
				
				
				end
				
				// ADDI
				ADDI_T3 : begin 
				
				
				end
				
				ADDI_T4 : begin 
				
				
				end
				
				ADDI_T5 : begin 
				
				
				end
				
				// SUB
				SUB_T3 : begin 
				
				
				end
				
				SUB_T4 : begin 
				
				
				end
				
				SUB_T5 : begin 
				
				
				end
				
				// MUL
				MUL_T3 : begin
				
				
				end
				
				MUL_T4 : begin
				
				
				end
				
				MUL_T5 : begin
				
				
				end
				
				MUL_T6 : begin
				
				
				end
				
				// DIV
				DIV_T3 : begin
				
				
				end
				
				DIV_T4 : begin
				
				
				end
				
				DIV_T5 : begin
				
				
				end
				
				DIV_T6 : begin
				
				
				end
				
				// AND
				AND_T3 : begin
				
				
				end
				
				AND_T4 : begin
				
				
				end
				
				AND_T5 : begin
				
				
				end
				
				// ANDI
				ANDI_T3 : begin
				
				
				end
				
				ANDI_T4 : begin
				
				
				end
				
				ANDI_T5 : begin
				
				
				end
				
				// OR
				OR_T3 : begin
				
				
				end
				
				OR_T4 : begin
				
				
				end
				
				OR_T5 : begin
				
				
				end
				
				// ORI
				ORI_T3 : begin
				
				
				end
				
				ORI_T4 : begin
				
				
				end
				
				ORI_T5 : begin
				
				
				end
				
				// SHR
				SHR_T3 : begin
				
				
				end
				
				SHR_T4 : begin
				
				
				end
				
				SHR_T5 : begin
				
				
				end
				
				// SHRA
				SHRA_T3 : begin
				
				
				end
				
				SHRA_T4 : begin
				
				
				end
				
				SHRA_T5 : begin
				
				
				end
				
				// SHL
				SHL_T3 : begin
				
				
				end
				
				SHL_T4 : begin
				
				
				end
				
				SHL_T5 : begin
				
				
				end
				
				// ROR
				ROR_T3 : begin
				
				end
				
				ROR_T4 : begin
				
				
				end
				
				ROR_T5 : begin
				
				
				end
				
				// ROL
				ROL_T3 : begin
				
				
				end
				
				ROL_T4 : begin
				
				
				end
				
				ROL_T5 : begin
				
				
				end
				
				// NEG
				NEG_T3 : begin
				
				end
				
				NEG_T4 : begin
				
				end
				
				// NOT
				NOT_T3 : begin
				
				end
				
				NOT_T4 : begin
				
				end
				
				
				// BRANCH instruction
				BR_T3  : begin
				
				end
				
				BR_T4  : begin
				
				end
				
				BR_T5  : begin
				
				end
				
				BR_T6  : begin
				
				end
				
				
				// JUMP instructions
				JR_T3 : begin
				
				end
				
				// JAL
				JAL_T3 : begin
				
				end
				
				JAL_T4 : begin
				
				end
				
				
				// IN/OUT and MFHI/LO instructions
				// IN
				IN_T3 : begin
				
				end
				
				IN_T4 : begin
				
				end
				
				// OUT
				OUT_T3 : begin
				
				end
				
				// MFHI
				MFHI_T3 : begin
				
				end
				
				// MFLO
				MFLO_T3 : begin
				
				end
				
				
				// MISC. instructions
				// NOP
				NOP_T3 : begin
				
				end
				
				// HALT
				HALT_T3 : begin
				
				end
					
			endcase
			
	end
	
endmodule
