// JAL control sequence
// T0: PCout, MARin, IncPC, Zlowin
// T1: Zlowout, PCin, MDMuxread, Mdatain, MDRin
// T2: MDRout, IRin
// T3: PCout, Grb, Rin
// T4: Gra, Rout, PCin

// JR control sequence
// T0: PCout, MARin, IncPC, Zlowin
// T1: Zlowout, PCin, MDMuxread, Mdatain, MDRin
// T2: MDRout, IRin
// T3: Gra, Rout, PCin


// testbench for JR and JAL instruction
// NOTE: FIX TESTBENCH SETTINGS BEFORE RUNNING THIS

// functionality
	// this tb performs JAL R6 and then JR R15
	// 0xF1 will be preloaded in R6
	// JAL R6 will move contents of R6 into PC, and PC+1 into R15(return address)
	// at ram address 0xF1(d241), opcode for JR R15 will be stored
	// JR R15 will move contents of R15(return address) into PC
	
// equivalent asm code
	// ldi 	R6, 0xF1
	// JAL 	R6
	// JR 	R15
	
// expected sequence of register contents
	// PC: 	0x0, 0x2,	0xF1, 0x2
	// R6: 	0x0, 0xF1
	// R15:	0x0, 0x2
		
		
`timescale 1ns/10ps
module datapath_tb_JUMP();

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

					// ldi R6, 0xF1, to preload R6
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

								
					// JAL R6
					5'b01000 : begin	// T0: PCout, MARin, IncPC, Zlowin
						PCout <= 1;		MARin <= 1;		IncPC <= 1;		Zlowin <= 1;
						#15 PCout <= 0; MARin <= 0; IncPC <= 0; Zlowin <= 0;
					end
					
					5'b01001 : begin	// T1: Zlowout, PCin, MDMuxread, RAMread, Mdatain, MDRin
						Zlowout <= 1; 		PCin <= 1; MDMuxread <= 1; RAMread <= 1; MDRin <= 1;
						#15 Zlowout <= 0; PCin <= 0; MDMuxread <= 0; RAMread <= 0; MDRin <= 0;
					end
					
					5'b01010 : begin 	// T2: MDRout, IRin
						MDRout <= 1; IRin <= 1;
						#15 MDRout <= 0; IRin <= 0;
					end
					
					5'b01011 : begin	// T3: PCout, Grb, Rin
						PCout <= 1; Grb <= 1; Rin <= 1;
						#15 PCout <= 0; Grb <= 0; Rin <= 0;
					end
					
					5'b01100 : begin	// T4: Gra, Rout, PCin
						Gra <= 1; Rout <= 1; PCin <= 1;
						#15 Gra <= 0; Rout <= 0; PCin <= 0;
					end
					
					
					// JR R15
					5'b01101 : begin	// T0: PCout, MARin, IncPC, Zlowin
						PCout <= 1; MARin <= 1; IncPC <= 1; PCin <= 1;
						#15 PCout <= 0; MARin <= 0; IncPC <= 0; PCin <= 0;
					end
					
					5'b01110 : begin 	// T1: Zlowout, PCin, MDMuxread, RAMread, Mdatain, MDRin
						Zlowout <= 1; PCin <= 1; MDMuxread <= 1; RAMread <= 1; MDRin <= 1;
						#15 Zlowout <= 0; PCin <= 0; MDMuxread <= 0; RAMread <= 0; MDRin <= 0;
					end
					
					5'b01111 : begin	// T2: MDRout, IRin
						MDRout <= 1; IRin <= 1;
						#15 MDRout <= 0; IRin <= 0;
					end
					
					5'b10000 : begin	// T3: Gra, Rout, PCin
						Gra <= 1; Rout <= 1; PCin <= 1;
						#15 Gra <= 0; Rout <= 0; PCin <= 0;
					end
					
			endcase
			
	end
	
endmodule
