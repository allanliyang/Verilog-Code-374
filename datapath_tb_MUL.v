// T0 : PCout, MARin, IncPC, Zin
// T1 : Zlowout, PCin, MDMuxread, Mdatain, MDRin
// T2 : MDRout, IRin
// T3 : R4out, Yin
// T4 : R5out, MUL, Zlowin, Zhighin
// T5 : Zlowout, LOin
// T6: Zhighout, HIin

// testbench for MUL instruction
// NOTE: FIX TESTBENCH SETTINGS BEFORE RUNNING THIS

// functionality:
  // this TB performs MUL R4, R5, results will be stored in HI and LO registers
  // with R2 = 1100 1011 (0x000000CB)
  // with R3 = 1100 0010 (0x000000C2)
  // and LO expected = 1100 1101 0110 (0x00000CD6)
  // and HI expected = 0
 
 `timescale 1ns/10ps
module datapath_tb_SHR();

reg clear, clock;
reg R0in, R1in, R2in, R3in;
reg R4in, R5in, R6in, R7in;
reg R8in, R9in, R10in, R11in;
reg R12in, R13in, R14in, R15in;
reg R0out, R1out, R2out, R3out;
reg R4out, R5out, R6out, R7out;
reg R8out, R9out, R10out, R11out;
reg R12out, R13out, R14out, R15out;
reg HIin, LOin, HIout, LOout;
reg Zhighin, Zlowin, Zhighout, Zlowout;
reg PCin, PCout;
reg MDRin, MDRout, MARin, MARout;
reg InPortin, InPortout;
reg CSEin, CSEout;
reg IRin, IRout;
reg [31:0] Mdatain; //only 32 bit value to sim data from mem chip
reg MDMuxread;
reg Yin;
reg ADD, SUB, MUL, DIV;
reg AND, OR;
reg SHR, SHRA, SHL;
reg ROR, ROL;
reg NEG, NOT;
reg IncPC;


parameter 	Default = 4'b0001, Reg_load1a = 4'b0010, Reg_load1b = 4'b0011, Reg_load2a = 4'b0100,
				Reg_load2b = 4'b0101, Reg_load3a = 4'b0110, Reg_load3b = 4'b0111, T0 = 4'b1000,
				T1 = 4'b1001, T2 = 4'b1010, T3 = 4'b1011, T4 = 4'b1100, T5 = 4'b1101; T6 = 4'b1110;

reg [3:0] Present_state = Default;

Datapath DUT	(clear, clock,
					R0in, R1in, R2in, R3in,
					R4in, R5in, R6in, R7in,
					R8in, R9in, R10in, R11in,
					R12in, R13in, R14in, R15in,
					R0out, R1out, R2out, R3out,
					R4out, R5out, R6out, R7out,
					R8out, R9out, R10out, R11out,
					R12out, R13out, R14out, R15out,
					HIin, LOin, HIout, LOout,
					Zhighin, Zlowin, Zhighout, Zlowout,
					PCin, PCout,
					MDRin, MDRout, MARin, MARout,
					InPortin, InPortout,
					CSEin, CSEout,
					IRin, IRout,
					Mdatain, MDMuxread,
					Yin,
					ADD, SUB, MUL, DIV,
					AND, OR,
					SHR, SHRA, SHL,
					ROR, ROL,
					NEG, NOT,
					IncPC
);

// test logic here
  initial begin clock = 0; Present_state = 4'b0000; end
  always #10 clock = ~clock;
  always @ (negedge clock) Present_state = Present_state + 1;
  
  always @ (Present_state)
        begin

          case (Present_state)
				Default: begin // 0001
						clear <= 1;
						R4in <= 0; 		R4out <= 0; 	R5in <= 0; 		R5out <= 0;
						Zhighin <= 0;	Zhighout <= 0; Zlowin <= 0;	Zlowout <= 0;
						HIin <= 0; 		LOin <= 0;
						MDRin <= 0; 	MDRout <= 0;		
						PCin <= 0;		PCout <= 0; 	 			
						IRin <= 0;		Yin <= 0;		
						IncPC <= 0;		MUL <= 0;
						Mdatain <= 32'h00000000;
						MDMuxread <= 0;
						#15 clear <= 0;
				end
				
				Reg_load1a: begin // 0010
						Mdatain <= 32'h000000CB;
						MDMuxread = 0; MDRin = 0;
						MDMuxread <= 1; MDRin <= 1;
						#15 MDMuxread <= 0; MDRin <= 0;
				end
				
				Reg_load1b: begin // 0011
						MDRout <= 1; R4in <= 1;
						#15 MDRout <= 0; R4in <= 0;
				end
				
				Reg_load2a: begin // 0100
						Mdatain <= 32'h000000C2;
						MDMuxread <= 1; MDRin <= 1;
						#15 MDMuxread <= 0; MDRin <= 0;
				end
				
				Reg_load2b: begin // 0101
						MDRout <= 1; R5in <= 1;
						#15 MDRout <= 0; R5in <= 0;
				end
				
				Reg_load3a: begin // 0110
						Mdatain <= 32'h00000012;
						MDMuxread <= 1; MDRin <= 1;
						#15 MDMuxread <= 0; MDRin <= 0;
				end
				
				Reg_load3b: begin // 0111
						MDRout <= 1; LOin <= 1; HIin <= 1;
						#15 MDRout <= 0; LOin <= 0; HIin <= 0;
				end 

				// At this point:
					// - 0b1100 1011 (0x000000CB) is loaded in R4
					// - 0b1100 0010 (0x000000C2) is loaded in R5  
					// - 0b10010 is loaded in HI and LO (idk why tho)
				
				// T0 -> T5 performs MUL R4, R5 and stores result into HI and LO
				// expected result in LO = 1100 1101 0110 (0x00000CD6)
				// expected result in HI = 0




































