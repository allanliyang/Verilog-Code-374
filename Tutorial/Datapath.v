// Datapath Module
module Datapath(
	input wire clock, clear,
	input wire [7:0] A, 
	input wire [7:0] RegisterAImmediate,
	input wire RZout, RAout, RBout,
	input wire RAin, RBin, RZin
);

wire [7:0] BusMuxOut, BusMuxInRZ, BusMuxInRA, BusMuxInRB; 

wire [7:0] Zregin;

//Devices
ETRegister RA(clear, clock, RAin, RegisterAImmediate, BusMuxInRA);
ETRegister RB(clear, clock, RBin, BusMuxOut, BusMuxInRB);

// adder
RCAdd add(A, BusMuxOut, Zregin);
ETRegister RZ(clear, clock, RZin, Zregin, BusMuxInRZ);

//Bus
BDBus bus(BusMuxInRZ, BusMuxInRA, BusMuxInRB, RZout, RAout, RBout, BusMuxOut);

endmodule

