module Datapath(
	input wire clear, clock,
	input wire R0in, R1in, R2in, R3in, 					// GP register in
	input wire R4in, R5in, R6in, R7in,
	input wire R8in, R9in, R10in, R11in,
	input wire R12in, R13in, R14in, R15in,
	input wire R0out, R1out, R2out, R3out, 			// GP register out
	input wire R4out, R5out, R6out, R7out,
	input wire R8out, R9out, R10out, R11out,
	input wire R12out, R13out, R14out, R15out,
	input wire HIin, LOin, HIout, LOout, 				// HI and LO in/out
	input wire Zhighin, Zlowin, Zhighout, Zlowout, 	// Z high and low in/out NOTE: check if single Zin signal can be used fro both Zhigh/low regs
	input wire PCin, PCout, 								// PC register in/out
	input wire MDRin, MDRout, MARin, MARout, 			// MDR and MAR in/out
	input wire InPortin, InPortout, 						// InPort in/out
	input wire CSEin, CSEout,								// C Sign Extended in/out
	input wire IRin, IRout,									// IR in/out										
	input wire [31:0] Mdatain,								// data into to MDR from mem. chip
	input wire MDMuxread,									// MDMux select signal
	input wire Yin,
	input wire ADD, SUB, MUL, DIV,
	input wire AND, OR,
	input wire SHR, SHRA, SHL,
	input wire ROR, ROL,
	input wire NEG, NOT,
	input wire IncPC											// signal for PC++
);

// declarations for bus connections
// datapaths that output onto the bus
wire [31:0] BusMuxOut; 															// bus mux out line
wire [31:0] BusMuxInR0, BusMuxInR1, BusMuxInR2, BusMuxInR3;			// output from GP registers
wire [31:0] BusMuxInR4, BusMuxInR5, BusMuxInR6, BusMuxInR7;
wire [31:0] BusMuxInR8, BusMuxInR9, BusMuxInR10, BusMuxInR11;
wire [31:0] BusMuxInR12, BusMuxInR13, BusMuxInR14, BusMuxInR15;

wire [31:0] BusMuxInHI, BusMuxInLO;											// output from HI and LO regs
wire [31:0] BusMuxInZhigh, BusMuxInZlow;									// output from Zhign and Zlow regs

wire [31:0] BusMuxInPC;															// output from PC register

wire [31:0] BusMuxInMDR;														// output from MDR register
wire [31:0] BusMuxInMAR;
wire [31:0] BusMuxInIR;															// output from IR register

wire [31:0] BusMuxInInPort;													// output from InPort
wire [31:0] BusMuxInCSE;														// output from C Sign Extended

//other datapaths
wire [31:0] Yout;
wire [31:0] Chigh, Clow;

// REGISTERS
// R0 - R15
Register32bit R0(clear, clock, R0in, BusMuxOut, BusMuxInR0);
Register32bit R1(clear, clock, R1in, BusMuxOut, BusMuxInR1);
Register32bit R2(clear, clock, R2in, BusMuxOut, BusMuxInR2);
Register32bit R3(clear, clock, R3in, BusMuxOut, BusMuxInR3);
Register32bit R4(clear, clock, R4in, BusMuxOut, BusMuxInR4);
Register32bit R5(clear, clock, R5in, BusMuxOut, BusMuxInR5);
Register32bit R6(clear, clock, R6in, BusMuxOut, BusMuxInR6);
Register32bit R7(clear, clock, R7in, BusMuxOut, BusMuxInR7);
Register32bit R8(clear, clock, R8in, BusMuxOut, BusMuxInR8);
Register32bit R9(clear, clock, R9in, BusMuxOut, BusMuxInR9);
Register32bit R10(clear, clock, R10in, BusMuxOut, BusMuxInR10);
Register32bit R11(clear, clock, R11in, BusMuxOut, BusMuxInR11);
Register32bit R12(clear, clock, R12in, BusMuxOut, BusMuxInR12);
Register32bit R13(clear, clock, R13in, BusMuxOut, BusMuxInR13);
Register32bit R14(clear, clock, R14in, BusMuxOut, BusMuxInR14);
Register32bit R15(clear, clock, R15in, BusMuxOut, BusMuxInR15);

// HI and LO registers
Register32bit HI(clear, clock, HIin, BusMuxOut, BusMuxInHI);
Register32bit LO(clear, clock, LOin, BusMuxOut, BusMuxInLO);

// Z registers (using hi and lo 32-bit instead of single 64 bit)
Register32bit Zhigh(clear, clock, Zhighin, Chigh, BusMuxInZhigh);
Register32bit Zlow(clear, clock, Zlowin, Clow, BusMuxInZlow); //NOTE: check inputs (Chigh/low) to Z registers

// PC register
Register32bit PC(clear, clock, PCin, BusMuxOut, BusMuxInPC);

// MDR register
MDR MDR(clear, clock, MDRin, MDMuxread, BusMuxOut, Mdatain, BusMuxInMDR); // only register that is not standard 32-bit register

// MAR register
Register32bit MAR(clear, clock, MARin, BusMuxOut, BusMuxInMAR);

// InPort register
Register32bit InPort(clear, clock, InPortIn, BusMuxOut, BusMuxInInPort);

// C Sign Extended register
Register32bit CSignExtended(clear, clock, CSEin, BusMuxOut, BusMuxInCSE);

// IR register
Register32bit IR(clear, clock, IRin, BusMuxOut, BusMuxInIR);

// Y register (for ALU)
Register32bit Y(clear, clock, Yin, BusMuxOut, Yout);

// NOTE: END OF REGISTER DECLARATIONS, CHECK THAT NONE WERE MISSED
// 02/10/2024/4:21 AM, i spent 3 hours trying to figure out why MDR wasn't working when 'clear' and 'clock' were switched
	// ^^ my 13th reason why



// BUS
Bus BUS	(R0out, R1out, R2out, R3out,
			R4out, R5out, R6out, R7out,
			R8out, R9out, R10out, R11out,
			R12out, R13out, R14out, R15out,
			HIout, LOout,
			Zhighout, Zlowout,
			PCout,
			MDRout,
			InPortout,
			CSEout,
			BusMuxInR0, BusMuxInR1, BusMuxInR2, BusMuxInR3,
			BusMuxInR4, BusMuxInR5, BusMuxInR6, BusMuxInR7,
			BusMuxInR8, BusMuxInR9, BusMuxInR10, BusMuxInR11,
			BusMuxInR12, BusMuxInR13, BusMuxInR14, BusMuxInR15,
			BusMuxInHI, BusMuxInLO,
			BusMuxInZhigh, BusMuxInZlow,
			BusMuxInPC,
			BusMuxInMDR,
			BusMuxInInPort,
			BusMuxInCSE,
			BusMuxOut); // BusMuxOut is only output from BUS
		
			
// ALU
ALU ALU	(Yout, BusMuxOut,
			ADD, SUB, MUL, DIV,
			AND, OR,
			SHR, SHRA, SHL,
			ROR, ROL,
			NEG, NOT, 
			IncPC,
			Chigh, Clow);
				
endmodule
