module ControlUnit (

	input clock, reset, stop, ConFFQ,
	input [31:0] IR,
	// no other input for this control unit, i.e. no interrupt functionality
	
	// use output regs because they can be assigned values inside of always statements
	output reg run, clear,
	output reg 





)