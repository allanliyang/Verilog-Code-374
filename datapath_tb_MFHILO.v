// control sequence for mfhi
// T0: PCout, MARin, IncPC, Zin
// T1: Zlowout, PCin, MDMuxread, Mdatain, MDRin
// T2: MDRout, IRin
// T3: HIout, Gra, Rin

// control sequence for mflo
// T0: PCout, MARin, IncPC, Zin
// T1: Zlowout, PCin, MDMuxread, Mdatain, MDRin
// T2: MDRout, IRin
// T3: LOout, Gra, Rin

// testbench for MFHI and MFLO instruction
// NOTE: FIX TESTBENCH SETTINGS BEFORE RUNNING THIS

// functionality
	// this tb performs mfhi R6 and mflo R7
  // preload hi and lo registers with values
  // perform mfhi, then mflo
		
`timescale 1ns/10ps
module datapath_tb_MFHILO();

endmodule
