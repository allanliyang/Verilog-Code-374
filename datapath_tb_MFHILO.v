// MFHI control sequence
// T0: PCout, MARin, IncPC, Zin
// T1: Zlowout, PCin, MDMuxread, Mdatain, MDRin
// T2: MDRout, IRin
// T3: HIout, Gra, Rin

// MFLO control sequence
// T0: PCout, MARin, IncPC, Zin
// T1: Zlowout, PCin, MDMuxread, Mdatain, MDRin
// T2: MDRout, IRin
// T3: LOout, Gra, Rin

// testbench for MFHI and MFLO instruction
// NOTE: FIX TESTBENCH SETTINGS BEFORE RUNNING THIS

// functionality
	// this tb performs mfhi R6 and then mflo R7
  // preload hi and lo registers with values
  // perform mfhi, then mflo

// equivalent asm code
	// ldi R6, 7FFFF (-1)
	// ldi R7, 0x1 (+1)
	// mul R6, R7
	// mfhi R6 (expected 0xFFFFFFFF)
	// mflo R7 (expected 0xFFFFFFFF)
		
`timescale 1ns/10ps
module datapath_tb_MFHILO();
	
	// reg declarations
	reg clear, clock;
	reg HIin, LOin, HIout, LOout;
	reg Zhighin, Zlowin, Zhighout, Zlowout;
	reg PCin, PCout;
	reg MDRin, MDRout, MARin;
	reg InPortout, OutPortin;
	reg CSEout;
	reg IRin;
	reg MDMuxread;
	reg Yin;
	reg ADD, SUB, MUL, DIV;
	reg AND, OR;
	reg SHR, SHRA, SHL;
	reg ROR, ROL;
	reg NEG, NOT;
	reg IncPC;
	reg Gra, Grb, Grc;
	reg Rin, Rout, BAout;
	reg [31:0]InPortdata;
	reg RAMread, RAMwrite;

	// outputs from datapath
	wire [31:0]OutPortdata;
	wire ConFFQ;


	reg [4:0]Present_state = 4'b00000;


	Datapath DUT 	(clear, clock,
						HIin, LOin, HIout, LOout,
						Zhighin, Zlowin, Zhighout, Zlowout,
						PCin, PCout,
						MDRin, MDRout, MARin,
						InPortout, OutPortin,
						CSEout,
						IRin,
						MDMuxread,
						Yin,
						ADD, SUB, MUL, DIV,
						AND, OR,
						SHR, SHRA, SHL,
						ROR, ROL,
						NEG, NOT, 
						IncPC,
						Gra, Grb, Grc,
						Rin, Rout, BAout,
						InPortdata,
						RAMread, RAMwrite,
						OutPortdata,
						ConFFQ);


	initial begin clock = 0; Present_state = 4'b0000; end
	always #10 clock = ~clock;
	always @ (negedge clock) Present_state = Present_state + 1;


	always @ (Present_state) begin
	
			case (Present_state)
					
					5'b00001 : begin 	// default case, clear registers and set all signals to low
						clear <= 1;
						PCin <= 0;		PCout <= 0;
						Zlowin <= 0;	Zlowout <= 0;
						MDRin <= 0; 	MDRout <= 0;	MDMuxread <= 0;	MARin <= 0;
						CSEout <= 0;
						IRin <= 0;
						Yin <= 0;
						IncPC <= 0;		ADD <= 0;
						Gra <= 0; 		Grb <= 0; 		Grc <= 0;
						Rin <= 0; 		Rout <= 0; 		BAout <= 0;
						RAMread <= 0;	RAMwrite <= 0;

						#15 clear <= 0;
					end


					// ldi R6, 0x3FFFF
					5'b00010 : begin	// T0: PCout, MARin, IncPC, Zlowin
						PCout <= 1;		MARin <= 1;		IncPC <= 1;		Zlowin <= 1;
						#15 PCout <= 0; MARin <= 0; IncPC <= 0; Zlowin <= 0;
					end
					
					5'b00011 : begin	// T1: Zlowout, PCin, MDMuxread, RAMread, Mdatain, MDRin
						Zlowout <= 1; 		PCin <= 1; 	MDMuxread <= 1; RAMread <= 1; MDRin <= 1;
						#15 Zlowout <= 0; PCin <= 0; 	MDMuxread <= 0; RAMread <= 0; MDRin <= 0;
					end
					
					5'b00100 : begin	// T2: MDRout, IRin
						MDRout <= 1; IRin <= 1;
						#15 MDRout <= 0; IRin <= 0;
					end
					
					5'b00101 : begin	// T3: Grb, BAout, Yin
						Grb <= 1; BAout <= 1; Yin <= 1;
						#15 Grb <= 0; BAout <= 0; Yin <= 0;
					end
					
					5'b00110 : begin	// T4: CSEout, ADD, Zlowin
						CSEout <= 1; ADD <= 1; Zlowin <= 1;
						#15 CSEout <= 0; ADD <= 0; Zlowin <= 0;
					end 
					
					5'b00111 : begin	// T5: Zlowout, Gra, Rin
						Zlowout <= 1; Gra <= 1; Rin <= 1;
						#15 Zlowout <= 0; Gra <= 0; Rin <= 0;
					end


					// ldi R7, 0x3FFFF
					5'b01000 : begin	// T0: PCout, MARin, IncPC, Zlowin
						PCout <= 1;		MARin <= 1;		IncPC <= 1;		Zlowin <= 1;
						#15 PCout <= 0; MARin <= 0; IncPC <= 0; Zlowin <= 0;
					end
					
					5'b01001 : begin	// T1: Zlowout, PCin, MDMuxread, RAMread, Mdatain, MDRin
						Zlowout <= 1; 		PCin <= 1; 	MDMuxread <= 1; RAMread <= 1; MDRin <= 1;
						#15 Zlowout <= 0; PCin <= 0; 	MDMuxread <= 0; RAMread <= 0; MDRin <= 0;
					end
					
					5'b01010 : begin 	// T2: MDRout, IRin
						MDRout <= 1; IRin <= 1;
						#15 MDRout <= 0; IRin <= 0;
					end
					
					5'b01011 : begin	// T3: Grb, BAout, Yin
						Grb <= 1; BAout <= 1; Yin <= 1;
						#15 Grb <= 0; BAout <= 0; Yin <= 0;
					end
					
					5'b01100 : begin	// T4: CSEout, ADD, Zlowin
						CSEout <= 1; ADD <= 1; Zlowin <= 1;
						#15 CSEout <= 0; ADD <= 0; Zlowin <= 0;
					end
					
					5'b01101 : begin	// T5: Zlowout, Gra, Rin
						Zlowout <= 1; Gra <= 1; Rin <= 1;
						#15 Zlowout <= 0; Gra <= 0; Rin <= 0;
					end


					// mul R6, R7
					5'b01110 : begin	// T0 : PCout, MARin, IncPC, Zlowin
						PCout <= 1;		MARin <= 1;		IncPC <= 1;		Zlowin <= 1;
						#15 PCout <= 0; MARin <= 0; IncPC <= 0; Zlowin <= 0;
					end

					5'b01111 : begin	// T1 : Zlowout, PCin, MDMuxread, RAMread, Mdatain, MDRin
						Zlowout <= 1; 		PCin <= 1; 	MDMuxread <= 1; RAMread <= 1; MDRin <= 1;
						#15 Zlowout <= 0; PCin <= 0; 	MDMuxread <= 0; RAMread <= 0; MDRin <= 0;
					end

					5'b10000 : begin	// T2 : MDRout, IRin
						MDRout <= 1; IRin <= 1;
						#15 MDRout <= 0; IRin <= 0;
					end

					5'b10001 : begin	// T3 : Gra, Rout, Yin
						Gra <= 1; Rout <= 1; Yin <= 1;
						#15 Gra <= 0; Rout <= 0; Yin <= 0;
					end

					5'b10010 : begin	// T4 : Grb, Rout, MUL, Zlowin, Zhighin
						Grb = 1; Rout <= 1; MUL <= 1; Zlowin <= 1; Zhighin <= 1;
						#15 Grb = 0; Rout <= 0; MUL <= 0; Zlowin <= 0; Zhighin <= 0;
					end

					5'b10011 : begin	// T5 : Zlowout, LOin
						Zlowout <= 1; LOin <= 1;
						#15 Zlowout <= 0; LOin <= 0;
					end

					5'b10100 : begin	// T6	: Zhighout, HIin
						Zhighout <= 1; HIin <= 1;
						#15 Zhighout <= 0; HIin <= 0;
					end


					// mfhi R6
					5'b10101 : begin	// T0: PCout, MARin, IncPC, Zlowin
						PCout <= 1;		MARin <= 1;		IncPC <= 1;		Zlowin <= 1;
						#15 PCout <= 0; MARin <= 0; IncPC <= 0; Zlowin <= 0;
					end

					5'b10110 : begin	// T1: Zlowout, PCin, MDMuxread, RAMread, Mdatain, MDRin
						Zlowout <= 1; 		PCin <= 1; 	MDMuxread <= 1; RAMread <= 1; MDRin <= 1;
						#15 Zlowout <= 0; PCin <= 0; 	MDMuxread <= 0; RAMread <= 0; MDRin <= 0;
					end

					5'b10111 : begin	// T2: MDRout, IRin
						MDRout <= 1; IRin <= 1;
						#15 MDRout <= 0; IRin <= 0;
					end

					5'b11000 : begin	// T3: HIout, Gra, Rin
						HIout <= 1; Gra <= 1; Rin <= 1;
						#15 HIout <= 0; Gra <= 0; Rin <= 0;
					end


					// mflo R7
					5'b11001 : begin	// T0: PCout, MARin, IncPC, Zlowin
						PCout <= 1;		MARin <= 1;		IncPC <= 1;		Zlowin <= 1;
						#15 PCout <= 0; MARin <= 0; IncPC <= 0; Zlowin <= 0;
					end

					5'b11010 : begin	// T1: Zlowout, PCin, MDMuxread, RAMread, Mdatain, MDRin
						Zlowout <= 1; 		PCin <= 1; 	MDMuxread <= 1; RAMread <= 1; MDRin <= 1;
						#15 Zlowout <= 0; PCin <= 0; 	MDMuxread <= 0; RAMread <= 0; MDRin <= 0;
					end

					5'b11011 : begin	// T2: MDRout, IRin
						MDRout <= 1; IRin <= 1;
						#15 MDRout <= 0; IRin <= 0;
					end

					5'b11100 : begin	// T3: LOout, Gra, Rin
						LOout <= 1; Gra <= 1; Rin <= 1;
						#15 LOout <= 0; Gra <= 0; Rin <= 0;
					end
					
			endcase
			
	end
	
endmodule
