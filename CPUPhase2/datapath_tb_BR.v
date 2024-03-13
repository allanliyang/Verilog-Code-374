// T0: PCout, MARin, IncPC, Zlowin
// T1: Zlowout, PCin, MDMuxread, RAMread, Mdatain, MDRin
// T2: MDRout, IRin
// T3: Gra, Rout, ConIn
// T4: PCout, Yin
// T5: CSEout, ADD, Zlowin
// T6: Zlowout, if(ConFFQ) then PCin


// functionality
	// this tb performs
	// br 	R5, 0xE(14) 
	// ldi R5, X, 
	// br 	R5, 0xE(14)
  
	// control sequence is the same for BRZR, BRNZ, BRPL, and BRMI
	// therefore this testbench is used for testing all branch instructions
	// only differnence between branch instructions is preloaded RAM opcode
	// R5 is always initially 0, depending on the branch instruction, it will either be taken or not taken
	// after first branch instruction, ldi opcode will be store at appropriate RAM address (branch either taken or not) 
	// ldi will load R5 with new value so result of next branch instruction will be opposite of initial
  
  
  
`timescale 1ns/10ps
module datapath_tb_BR();

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
	reg ConIn;

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
			 			ConIn,
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

					// brzr R5, 0xE(d14)
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
					
					5'b00101 : begin	// T3: Gra, Rout, ConIn
						Gra <= 1; Rout <= 1; ConIn <= 1;
						#15 Gra <= 0; Rout <= 0; ConIn <= 0;
					end
					
					5'b00110 : begin	// T4: PCout, Yin
						PCout <= 1; Yin <= 1;
						#15 PCout <= 0; Yin <= 0;
					end 
					
					5'b00111 : begin	// T5: CSEout, ADD, Zlowin
						CSEout <= 1; ADD <= 1; Zlowin <= 1;
						#15 CSEout <= 0; ADD<= 0; Zlowin <= 0;
					end
					
					5'b01000 : begin	// T6: Zlowout, if(ConFFQ) then PCin
						Zlowout <= 1;
            
						if (ConFFQ) begin
							PCin <= 1;
						end
            
						#15 Zlowout <= 0; PCin <= 0;
					end

        
					// ldi R5, 0x1 (preload R5 so next 'brzr R5' does not branch 
					5'b01001 : begin	// T0: PCout, MARin, IncPC, Zlowin
						PCout <= 1;		MARin <= 1;		IncPC <= 1;		Zlowin <= 1;
						#15 PCout <= 0; MARin <= 0; IncPC <= 0; Zlowin <= 0;
					end
					
					5'b01010 : begin 	// T1: Zlowout, PCin, MDMuxread, RAMread, Mdatain, MDRin
						Zlowout <= 1; 		PCin <= 1; 	MDMuxread <= 1; RAMread <= 1; MDRin <= 1;
						#15 Zlowout <= 0; PCin <= 0; 	MDMuxread <= 0; RAMread <= 0; MDRin <= 0;
					end
					
					5'b01011 : begin	// T2: MDRout, IRin
					  MDRout <= 1; IRin <= 1;
						#15 MDRout <= 0; IRin <= 0;
					end
					
					5'b01100 : begin	// T3: Grb, BAout, Yin
						Grb <= 1; BAout <= 1; Yin <= 1;
						#15 Grb <= 0; BAout <= 0; Yin <= 0;
					end
					
					5'b01101 : begin	// T4: CSEout, ADD, Zlowin
						CSEout <= 1; ADD <= 1; Zlowin <= 1;
						#15 CSEout <= 0; ADD <= 0; Zlowin <= 0;
					end

					5'b01110 : begin  // T5: Zlowout, Gra, Rin
						Zlowout <= 1; Gra <= 1; Rin <= 1;
						#15 Zlowout <= 0; Gra <= 0; Rin <= 0;
					end


					// brzr R5, 0xE (should not branch)
					5'b01111 : begin	// T0: PCout, MARin, IncPC, Zlowin
						PCout <= 1;		MARin <= 1;		IncPC <= 1;		Zlowin <= 1;
						#15 PCout <= 0; MARin <= 0; IncPC <= 0; Zlowin <= 0;
					end
					
					5'b10000 : begin	// T1: Zlowout, PCin, MDMuxread, RAMread, Mdatain, MDRin
						Zlowout <= 1; 		PCin <= 1; 	MDMuxread <= 1; RAMread <= 1; MDRin <= 1;
						#15 Zlowout <= 0; PCin <= 0; 	MDMuxread <= 0; RAMread <= 0; MDRin <= 0;
					end
					
					5'b10001 : begin	// T2: MDRout, IRin
						MDRout <= 1; IRin <= 1;
						#15 MDRout <= 0; IRin <= 0;
					end
					
					5'b10010 : begin	// T3: Gra, Rout, ConIn
						Gra <= 1; Rout <= 1; ConIn <= 1;
						#15 Gra <= 0; Rout <= 0; ConIn <= 0;
					end
					
					5'b10011 : begin	// T4: PCout, Yin
						PCout <= 1; Yin <= 1;
						#15 PCout <= 0; Yin <= 0;
					end 
					
					5'b10100 : begin	// T5: CSEout, ADD, Zlowin
						CSEout <= 1; ADD <= 1; Zlowin <= 1;
						#15 CSEout <= 0; ADD <= 0; Zlowin <= 0;
					end
					
					5'b10101 : begin	// T6: Zlowout, if(ConFFQ) then PCin
						Zlowout <= 1;
            
						if (ConFFQ) begin
							PCin <= 1;
						end
            
						#15 Zlowout <= 0; PCin <= 0;
					end
					
					
					// continued to see next PC value
					5'b10110 : begin
						PCout <= 1;		MARin <= 1;		IncPC <= 1;		Zlowin <= 1;
						#15 PCout <= 0; MARin <= 0; IncPC <= 0; Zlowin <= 0;
					end
					
					5'b10111 : begin
						Zlowout <= 1; 		PCin <= 1; 	MDMuxread <= 1; RAMread <= 1; MDRin <= 1;
						#15 Zlowout <= 0; PCin <= 0; 	MDMuxread <= 0; RAMread <= 0; MDRin <= 0;
					end
					
					5'b11000 : begin
						MDRout <= 1; IRin <= 1;
						#15 MDRout <= 0; IRin <= 0;
					end
					
			endcase
			
	end
	
endmodule
