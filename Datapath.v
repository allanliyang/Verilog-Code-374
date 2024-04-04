module Datapath(
	input wire clock, reset, stop,
	input wire [31:0]InPortdata,							// simulated signal from input unit

	output wire [31:0]OutPortdata							// data from OutPort
);

// declarations for bus connections
// datapaths that output onto the bus
wire [31:0]BusMuxOut; 															// bus mux out line
wire [31:0]BusMuxInR0, BusMuxInR1, BusMuxInR2, BusMuxInR3;			// output from GP registers
wire [31:0]BusMuxInR4, BusMuxInR5, BusMuxInR6, BusMuxInR7;
wire [31:0]BusMuxInR8, BusMuxInR9, BusMuxInR10, BusMuxInR11;
wire [31:0]BusMuxInR12, BusMuxInR13, BusMuxInR14, BusMuxInR15;

wire [31:0]BusMuxInHI, BusMuxInLO;											// output from HI and LO regs
wire [31:0]BusMuxInZhigh, BusMuxInZlow;									// output from Zhign and Zlow regs

wire [31:0]BusMuxInPC;															// output from PC register

wire [31:0]BusMuxInMDR;															// output from MDR register
wire [31:0]BusMuxInMAR;
wire [31:0]BusMuxInIR;															// output from IR register

wire [31:0]BusMuxInInPort;														// output from InPort
wire [31:0]BusMuxInCSE;															// output from C Sign Extended

// interal Rxin and Rxout signals generated by SelectEncode
wire R0in, R1in, R2in, R3in; 					// GP register in
wire R4in, R5in, R6in, R7in;
wire R8in, R9in, R10in, R11in;
wire R12in, R13in, R14in, R15in;
wire R0out, R1out, R2out, R3out; 			// GP register out
wire R4out, R5out, R6out, R7out;
wire R8out, R9out, R10out, R11out;
wire R12out, R13out, R14out, R15out;

wire [31:0]Mdatain;								// data into to MDR from mem. chip

wire [31:0]IRout;									// internal signal connecting IR register to SelectEncode

wire [8:0]MARAddrOut;							// internal signal for address from MAR

wire [31:0]OutPortout;



wire ConFFQ;										// output from ConFF

wire clear;
wire MEMread, MEMwrite;
wire Rin, Rout, BAout;
wire Gra, Grb, Grc;								// signals for SelectEncode in Phase 2


// ALU control signals
wire ADD, SUB, MUL, DIV;
wire AND, OR;
wire SHR, SHRA, SHL;
wire ROR, ROL;
wire NEG, NOT;
wire IncPC;											// signal for PC++

wire PCin, PCout; 								// PC register in/out
wire IRin;											// IR in	
wire MDRin, MDRout, MARin;			 			// MDR and MAR in/out
wire Zhighin, Zlowin, Zhighout, Zlowout; 	// Z high and low in/out
wire HIin, LOin, HIout, LOout; 				// HI and LO in/out
wire CSEout;										// C Sign Extended out
wire Yin;
wire ConIn;										// trigger for Con flip-flop
wire InPortout; 									// InPort in/out
wire OutPortin;

	
// signal paths connecting ALU to Y and Z regs
wire [31:0] Yout;
wire [31:0] Chigh, Clow;

// interal divided clock connection
//wire clock;

// Clock Divider
//ClockDivider CD(clock, clockUNDIV);

// REGISTERS
// R0 - R15
R0 R0(clear, clock, R0in, BAout, BusMuxOut, BusMuxInR0);				// special file for R0 (includes BAout signal)
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
Register32bit Zlow(clear, clock, Zlowin, Clow, BusMuxInZlow);

// PC register
Register32bit PC(clear, clock, PCin, BusMuxOut, BusMuxInPC);

// MDR register
MDR MDR(clear, clock, MDRin, MEMread, BusMuxOut, Mdatain, BusMuxInMDR);

// MAR register
MAR MAR(clear, clock, MARin, BusMuxOut, MARAddrOut);

// InPort register
InPort InPort(clear, clock, InPortdata, BusMuxInInPort);

//OutPort register
Register32bit OutPort(clear, clock, OutPortin, BusMuxOut, OutPortout);

// C Sign Extended register
//Register32bit CSignExtended(clear, clock, CSEin, BusMuxOut, BusMuxInCSE);

// IR register
Register32bit IR(clear, clock, IRin, BusMuxOut, IRout);	// NOTE: IRout connects to SelectEncode

// Y register (for ALU)
Register32bit Y(clear, clock, Yin, BusMuxOut, Yout);



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
			
			

				
RAM RAM (MEMread, MEMwrite, MARAddrOut, BusMuxOut, Mdatain);



SelectEncode SELogic 	(IRout, Gra, Grb, Grc,
								Rin, Rout, BAout,
								R0in, R1in, R2in, R3in,
								R4in, R5in, R6in, R7in,
								R8in, R9in, R10in, R11in,
								R12in, R13in, R14in, R15in,
								R0out, R1out, R2out, R3out,
								R4out, R5out, R6out, R7out,
								R8out, R9out, R10out, R11out,
								R12out, R13out, R14out, R15out,
								BusMuxInCSE);
								
								
								

// ConFF logic
ConFFLogic ConFF(ConIn, IRout, BusMuxOut, ConFFQ);


// NOTE: FIX CONTROL UNIT
ControlUnit CU	(clear,
					MEMread, MEMwrite,
					Rin, Rout, BAout,
					Gra, Grb, Grc,
					ADD, SUB, MUL, DIV,
					AND, OR,
					SHR, SHRA, SHL,
					ROR, ROL,
					NEG, NOT,
					IncPC,
					PCin, PCout, IRin,
					MDRin, MDRout, MARin,
					Zhighin, Zlowin, Zhighout, Zlowout,
					HIin, LOin, HIout, LOout,
					CSEout,
					Yin,
					ConIn,
					OutPortin, InPortout,
					IRout,
					clock, reset, stop, ConFFQ,
					clearCU
					);


assign OutPortdata = OutPortout;

endmodule
