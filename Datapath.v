module Datapath(
	input wire clock, clear,
	input wire R0out, R1out, R2out, R3out,
	input wire R4out, R5out, R6out, R7out,
	input wire R8out, R9out, R10out, R11out,
	input wire R12out, R13out, R14out, R15out,
	input wire HIout, LOout,
	input wire Zhighout, Zlowout,
	input wire PCout, MDRout, InPortout, Cout
);


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
Register32bit Zhigh(clear, clock, Zhighin, BusMuxOut, BusMuxInZhigh);
Register32bit Zlow(clear, clock, Zlowin, BusMuxOut, BusMuxInZlow);

// PC register
Register32bit PC(clear, clock, PCin, BusMuxOut, BusMuxInPC);

// MDR register
MDR MDR(); // only register that is not standard 32-bit register

// MAR register
Register32bit MAR(clear, clock, MARin, BusMuxOut, MARout);

// InPort register?


// C Sign Extended register?


// IR register
Register32bit IR(clear, clock, IRin, BusMuxOut, BusMuxInIR); // NOTE: CHECK HOW THIS REGISTER IS SUPPOSED TO WORK WITH BUS

// Y register (for ALU)
Register32bit Y(clear, clock, Yin, BusMuxOut, Yout);

// BW: END OF REGISTER DECLARATIONS, CHECK THAT NONE WERE MISSED



// BUS
Bus BUS	(R0out, R1out, R2out, R3out, R4out, R5out, R6out, R7out,
			R8out, R9out, R10out, R11out, R12out, R13out, R14out, R15out, // NOTE: CHECK IF INPUTS CAN BE ON MULTIPLE LINES
			HIout, LOout, Zhighout, Zlowout,
			PCout, MDRout, InPortout, Cout,
			BusMuxInR0, BusMuxInR1, BusMuxInR2, BusMuxInR3,
			BusMuxInR4, BusMuxInR5, BusMuxInR6, BusMuxInR7,
			BusMuxInR8, BusMuxInR9, BusMuxInR10, BusMuxInR11,
			BusMuxInR12, BusMuxInR13, BusMuxInR14, BusMuxInR15,
			BusMuxInHI, BusMuxInLO, BusMuxInZhigh, BusMuxInZlow,
			BusMuxInPC, BusMuxInMDR, BusMuxInInPort, CSignExtended,
			BusMuxOut); // BusMuxOut is only output from BUS
//BW: END OF BUS DECLARATION, CHECK THAT ALL VARIABLES WERE USED CORRECTLY
			
			
// ALU
// TEMPORARILY USING IN-PROGRESS ALU TO JUST TEST AND FUNCTIONALITY
ALU ALU_AND	(A, B,
				ADD, SUB, MUL, DIV,
				AND, OR, SHR, SHRA,
				SHL, ROR, ROL, NEG, NOT,
				Chigh,Clow); // NOTE: WILL NEED TO FIX ALU LATER
				
endmodule
