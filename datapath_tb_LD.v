// T0: PCout, MARin, IncPC, Zin
// T1: Zlowout, PCin, MDMuxread, Mdatain, MDRin
// T2: MDRout, IRin
// T3: Grb, BAout, Yin
// T4: Cout, ADD, Zlowin
// T5: Zlowout, MARin
// T6: MDMuxread, Mdatain, MDRin
// T7: MDRout, Gra, Rin

// testbench for LD instruction
// NOTE: FIX TESTBENCH SETTINGS BEFORE RUNNING THIS

// functionality
	// this tb performs ld R2,0x95 and ld R0, 0x38(R2)
		
`timescale 1ns/10ps
module datapath_tb_LD();

	// reg declarations
	reg clear, clock;
	reg HIin, LOin, HIout, LOout;
	reg Zhighin, Zlowin, Zhighout, Zlowout;
	reg PCin, PCout;
	reg MDRin, MDRout, MARin;
	reg InPortout, OutPortin;
	reg CSEout;
	reg IRin;
	reg MDMuxRead;
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
	reg [31:0]OutPortdata
	reg ConFFQ;

	// parameter declarations
	

	// reg [3:0]Present_state = Default;

	Datapath DUT (clear, clock,
		      HIin, LOin, HIout, LOout,
		      Zhighin, Zlowin, Zhighout, Zlowout,
		      PCin, PCout,
		      MDRin, MDRout, MARin,
		      InPortout, OutPortin,
		      CSEout,
		      IRin,
		      MDMuxread,
		      Yin,
		      ADD, SUB, MUL, DIV
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


	
		      







	

endmodule
