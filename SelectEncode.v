module SelectEncode (
	input [31:0] IR,
	input Gra, Grb, Grc,
	input Rin, Rout, BAout,
	output R0in, R1in, R2in, R3in,
	output R4in, R5in, R6in, R7in,
	output R8in, R9in, R10in, R11in,
	output R12in, R13in, R14in, R15in,
	output R0out, R1out, R2out, R3out,
	output R4out, R5out, R6out, R7out,
	output R8out, R9out, R10out, R11out,
	output R12out, R13out, R14out, R15out,
	output wire[31:0] BusMuxInCSE
);

// addresses of ra, rb, and rc from opcode
reg [3:0]ra;
reg [3:0]rb;
reg [3:0]rc;

// 16-bit registers used to hold values for R0in/out -> R15in/out
reg [15:0]Rxin;
reg [15:0]Rxout;

// 32-bit register for BusMuxInCSE
reg [31:0]q;

initial begin
	
	Rxin = 16'h0000;
	Rxout = 16'h0000;
	q = 32'h00000000;
	
end

always @ (*) begin
	
	// get ra, rb, and rc values from opcode
	ra = IR[26:23];
	rb = IR[22:19];
	rc = IR[18:15];
	
	// get C value from opcode
	q[18:0] = IR[18:0];

	// non-blocking assignments used that will be overwritten with '1' in proper cases
	Rxin <= 16'h0000;
	Rxout <= 16'h0000;
	
	// check cases for which Rxin or Rxout signal to set to '1'
	if (Rin) begin
		if (Gra) begin
			case (ra)
				4'b0000 : Rxin[0] <= 1;
				4'b0001 : Rxin[1] <= 1;
				4'b0010 : Rxin[2] <= 1;
				4'b0011 : Rxin[3] <= 1;
				4'b0100 : Rxin[4] <= 1;
				4'b0101 : Rxin[5] <= 1;
				4'b0110 : Rxin[6] <= 1;
				4'b0111 : Rxin[7] <= 1;
				4'b1000 : Rxin[8] <= 1;
				4'b1001 : Rxin[9] <= 1;
				4'b1010 : Rxin[10] <= 1;
				4'b1011 : Rxin[11] <= 1;
				4'b1100 : Rxin[12] <= 1;
				4'b1101 : Rxin[13] <= 1;
				4'b1110 : Rxin[14] <= 1;
				4'b1111 : Rxin[15] <= 1;
			endcase	
		end
		
		else if (Grb) begin
			case (rb)
				4'b0000 : Rxin[0] <= 1;
				4'b0001 : Rxin[1] <= 1;
				4'b0010 : Rxin[2] <= 1;
				4'b0011 : Rxin[3] <= 1;
				4'b0100 : Rxin[4] <= 1;
				4'b0101 : Rxin[5] <= 1;
				4'b0110 : Rxin[6] <= 1;
				4'b0111 : Rxin[7] <= 1;
				4'b1000 : Rxin[8] <= 1;
				4'b1001 : Rxin[9] <= 1;
				4'b1010 : Rxin[10] <= 1;
				4'b1011 : Rxin[11] <= 1;
				4'b1100 : Rxin[12] <= 1;
				4'b1101 : Rxin[13] <= 1;
				4'b1110 : Rxin[14] <= 1;
				4'b1111 : Rxin[15] <= 1;
			endcase	
		end
		
		else if (Grc) begin
			case (rc)
				4'b0000 : Rxin[0] <= 1;
				4'b0001 : Rxin[1] <= 1;
				4'b0010 : Rxin[2] <= 1;
				4'b0011 : Rxin[3] <= 1;
				4'b0100 : Rxin[4] <= 1;
				4'b0101 : Rxin[5] <= 1;
				4'b0110 : Rxin[6] <= 1;
				4'b0111 : Rxin[7] <= 1;
				4'b1000 : Rxin[8] <= 1;
				4'b1001 : Rxin[9] <= 1;
				4'b1010 : Rxin[10] <= 1;
				4'b1011 : Rxin[11] <= 1;
				4'b1100 : Rxin[12] <= 1;
				4'b1101 : Rxin[13] <= 1;
				4'b1110 : Rxin[14] <= 1;
				4'b1111 : Rxin[15] <= 1;
			endcase	
		end
	end
	
	if (Rout | BAout) begin
		if (Gra) begin
			case (ra)
				4'b0000 : Rxout[0] <= 1;
				4'b0001 : Rxout[1] <= 1;
				4'b0010 : Rxout[2] <= 1;
				4'b0011 : Rxout[3] <= 1;
				4'b0100 : Rxout[4] <= 1;
				4'b0101 : Rxout[5] <= 1;
				4'b0110 : Rxout[6] <= 1;
				4'b0111 : Rxout[7] <= 1;
				4'b1000 : Rxout[8] <= 1;
				4'b1001 : Rxout[9] <= 1;
				4'b1010 : Rxout[10] <= 1;
				4'b1011 : Rxout[11] <= 1;
				4'b1100 : Rxout[12] <= 1;
				4'b1101 : Rxout[13] <= 1;
				4'b1110 : Rxout[14] <= 1;
				4'b1111 : Rxout[15] <= 1;
			endcase	
		end
		
		else if (Grb) begin
			case (rb)
				4'b0000 : Rxout[0] <= 1;
				4'b0001 : Rxout[1] <= 1;
				4'b0010 : Rxout[2] <= 1;
				4'b0011 : Rxout[3] <= 1;
				4'b0100 : Rxout[4] <= 1;
				4'b0101 : Rxout[5] <= 1;
				4'b0110 : Rxout[6] <= 1;
				4'b0111 : Rxout[7] <= 1;
				4'b1000 : Rxout[8] <= 1;
				4'b1001 : Rxout[9] <= 1;
				4'b1010 : Rxout[10] <= 1;
				4'b1011 : Rxout[11] <= 1;
				4'b1100 : Rxout[12] <= 1;
				4'b1101 : Rxout[13] <= 1;
				4'b1110 : Rxout[14] <= 1;
				4'b1111 : Rxout[15] <= 1;
			endcase	
		end
		
		else if (Grc) begin
			case (rc)
				4'b0000 : Rxout[0] <= 1;
				4'b0001 : Rxout[1] <= 1;
				4'b0010 : Rxout[2] <= 1;
				4'b0011 : Rxout[3] <= 1;
				4'b0100 : Rxout[4] <= 1;
				4'b0101 : Rxout[5] <= 1;
				4'b0110 : Rxout[6] <= 1;
				4'b0111 : Rxout[7] <= 1;
				4'b1000 : Rxout[8] <= 1;
				4'b1001 : Rxout[9] <= 1;
				4'b1010 : Rxout[10] <= 1;
				4'b1011 : Rxout[11] <= 1;
				4'b1100 : Rxout[12] <= 1;
				4'b1101 : Rxout[13] <= 1;
				4'b1110 : Rxout[14] <= 1;
				4'b1111 : Rxout[15] <= 1;
			endcase	
		end
	end
	
	if (q[18]) begin
		q[31:19] = 13'b1111111111111;
	end
	else
		q[31:19] = 13'b0000000000000;
	end
	
end

// assign Rin and Rout signals based on values in Rxin and Rxout registers
assign R0in = Rxin[0];
assign R1in = Rxin[1];
assign R2in = Rxin[2];
assign R3in = Rxin[3];
assign R4in = Rxin[4];
assign R5in = Rxin[5];
assign R6in = Rxin[6];
assign R7in = Rxin[7];
assign R8in = Rxin[8];
assign R9in = Rxin[9];
assign R10in = Rxin[10];
assign R11in = Rxin[11];
assign R12in = Rxin[12];
assign R13in = Rxin[13];
assign R14in = Rxin[14];
assign R15in = Rxin[15];

assign R0out = Rxout[0];
assign R1out = Rxout[1];
assign R2out = Rxout[2];
assign R3out = Rxout[3];
assign R4out = Rxout[4];
assign R5out = Rxout[5];
assign R6out = Rxout[6];
assign R7out = Rxout[7];
assign R8out = Rxout[8];
assign R9out = Rxout[9];
assign R10out = Rxout[10];
assign R11out = Rxout[11];
assign R12out = Rxout[12];
assign R13out = Rxout[13];
assign R14out = Rxout[14];
assign R15out = Rxout[15];

// assign output to bus for CSE
assign BusMuxInCSE = q;

endmodule
