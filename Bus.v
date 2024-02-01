module Bus (
		input R0out, R1out, R2out, R3out,
				R4out, R5out, R6out, R7out,
				R8out, R9out, R10out, R11out,
				R12out, R13out, R14out, R15out,
				HIout, LOout,
				Zhighout, Zlowout,
				PCout,
				MDRout,
				InPortout,
				Cout,
		input [31:0]BusMuxinR0, [31:0]BusMuxInR1, [31:0]BusMuxInR2, [31:0]BusMuxInR3,
				[31:0]BusMuxInR4, [31:0]BusMuxInR5, [31:0]BusMuxInR6, [31:0]BusMuxInR7,
				[31:0]BusMuxInR8, [31:0]BusMuxInR9, [31:0]BusMuxInR10, [31:0]BusMuxInR11,
				[31:0]BusMuxInR12, [31:0]BusMuxInR13, [31:0]BusMuxInR14, [31:0]BusMuxInR15,
				[31:0]BusMuxInHI, [31:0]BusMuxInLO,
				[31:0]BusMuxInZhigh, [31:0]BusMuxInZlow,
				[31:0]BusMuxInPC,
				[31:0]BusMuxInMDR,
				[31:0]BusMuxInInPort,
				[31:0]CSignExtended
		output wire [31:0]BusMuxOut
);

reg [31:0]q;

always @ (*) begin
	if (R0out) q = BusMuxInR0;
	else if (R1out) q = BusMuxInR1;
	else if (R2out) q = BusMuxInR2;
	else if (R3out) q = BusMuxInR3;
	else if (R4out) q = BusMuxInR4;
	else if (R5out) q = BusMuxInR5;
	else if (R6out) q = BusMuxInR6;
	else if (R7out) q = BusMuxInR7;
	else if (R8out) q = BusMuxInR8;
	else if (R9out) q = BusMuxInR9;
	else if (R10out) q = BusMuxInR10;
	else if (R11out) q = BusMuxInR11;
	else if (R12Out) q = BusMuxInR12;
	else if (R13out) q = BusMuxInR13;
	else if (R14out) q = BusMuxInR14;
	else if (R15out) q = BusMuxInR15;
	
	else if (HIout) q = BusMuxInHI;
	else if (LOout) q = BusMuxInLO;
	
	else if (Zhighout) q = BusMuxInZhigh;
	else if (Zlowout) q = BusMuxInZlow;
	
	else if (PCout) q = BusMuxInPC;
		
	else if (MDRout) q = BusMuxInMDR;
	
	else if (InPortout) q = BusMuxInInPort;
	
	else if (Cout) q = CSignExtended;
end

assign BusMuxout = q;
endmodule
