module SelectEncode (
	input [31:0] IR,
	input Gra, Grb, Grc,
	input Rin, Rout, BAout,
	output wire[31:0] CSE, // NOTE: check if output wire ?
	output R0in, R1in, R2in, R3in,
	output R4in, R5in, R6in, R7in,
	output R8in, R9in, R10in, R11in,
	output R12in, R13in, R14in, R15in,
	output R0out, R1out, R2out, R3out,
	output R4out, R5out, R6out, R7out,
	output R8out, R9out, R10out, R11out,
	output R12out, R13out, R14out, R15out
);


reg [3:0]ra;
reg [3:0]rb;
reg [3:0]rc;


always @ (*) begin

	ra = IR[26:23];
	rb = IR[22:19];
	rc = IR[18:15];

	//NOTE: add resets to 0 for signals
	
	if (Rin) begin
		if (Gra) begin
			case (ra)
				4'b0000 : R0in = 1;
				4'b0001 : R1in = 1;
				4'b0010 : R2in = 1;
				4'b0011 : R3in = 1;
				4'b0100 : R4in = 1;
				4'b0101 : R5in = 1;
				4'b0110 : R6in = 1;
				4'b0111 : R7in = 1;
				4'b1000 : R8in = 1;
				4'b1001 : R9in = 1;
				4'b1010 : R10in = 1;
				4'b1011 : R11in = 1;
				4'b1100 : R12in = 1;
				4'b1101 : R13in = 1;
				4'b1110 : R14in = 1;
				4'b1111 : R15in = 1;
			endcase	
		end
		
		else if (Grb) begin
			case (rb)
				4'b0000 : R0in = 1;
				4'b0001 : R1in = 1;
				4'b0010 : R2in = 1;
				4'b0011 : R3in = 1;
				4'b0100 : R4in = 1;
				4'b0101 : R5in = 1;
				4'b0110 : R6in = 1;
				4'b0111 : R7in = 1;
				4'b1000 : R8in = 1;
				4'b1001 : R9in = 1;
				4'b1010 : R10in = 1;
				4'b1011 : R11in = 1;
				4'b1100 : R12in = 1;
				4'b1101 : R13in = 1;
				4'b1110 : R14in = 1;
				4'b1111 : R15in = 1;
			endcase	
		end
		
		else if (Grc) begin
			case (rc)
				4'b0000 : R0in = 1;
				4'b0001 : R1in = 1;
				4'b0010 : R2in = 1;
				4'b0011 : R3in = 1;
				4'b0100 : R4in = 1;
				4'b0101 : R5in = 1;
				4'b0110 : R6in = 1;
				4'b0111 : R7in = 1;
				4'b1000 : R8in = 1;
				4'b1001 : R9in = 1;
				4'b1010 : R10in = 1;
				4'b1011 : R11in = 1;
				4'b1100 : R12in = 1;
				4'b1101 : R13in = 1;
				4'b1110 : R14in = 1;
				4'b1111 : R15in = 1;
			endcase	
		end
	end
	
	if (Rout | BAout) begin
		if (Gra) begin
			case (ra)
				4'b0000 : R0out = 1;
				4'b0001 : R1out = 1;
				4'b0010 : R2out = 1;
				4'b0011 : R3out = 1;
				4'b0100 : R4out = 1;
				4'b0101 : R5out = 1;
				4'b0110 : R6out = 1;
				4'b0111 : R7out = 1;
				4'b1000 : R8out = 1;
				4'b1001 : R9out = 1;
				4'b1010 : R10out = 1;
				4'b1011 : R11out = 1;
				4'b1100 : R12out = 1;
				4'b1101 : R13out = 1;
				4'b1110 : R14out = 1;
				4'b1111 : R15out = 1;
			endcase	
		end
		
		else if (Grb) begin
			case (rb)
				4'b0000 : R0out = 1;
				4'b0001 : R1out = 1;
				4'b0010 : R2out = 1;
				4'b0011 : R3out = 1;
				4'b0100 : R4out = 1;
				4'b0101 : R5out = 1;
				4'b0110 : R6out = 1;
				4'b0111 : R7out = 1;
				4'b1000 : R8out = 1;
				4'b1001 : R9out = 1;
				4'b1010 : R10out = 1;
				4'b1011 : R11out = 1;
				4'b1100 : R12out = 1;
				4'b1101 : R13out = 1;
				4'b1110 : R14out = 1;
				4'b1111 : R15out = 1;
			endcase	
		end
		
		else if (Grc) begin
			case (rc)
				4'b0000 : R0out = 1;
				4'b0001 : R1out = 1;
				4'b0010 : R2out = 1;
				4'b0011 : R3out = 1;
				4'b0100 : R4out = 1;
				4'b0101 : R5out = 1;
				4'b0110 : R6out = 1;
				4'b0111 : R7out = 1;
				4'b1000 : R8out = 1;
				4'b1001 : R9out = 1;
				4'b1010 : R10out = 1;
				4'b1011 : R11out = 1;
				4'b1100 : R12out = 1;
				4'b1101 : R13out = 1;
				4'b1110 : R14out = 1;
				4'b1111 : R15out = 1;
			endcase	
		end
	end


endmodule
