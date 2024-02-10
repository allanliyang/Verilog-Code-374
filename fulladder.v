// 1 bit full adder

module fulladder (
	input a, b, cin,
	output sum, carry
	
);

assign sum = a ^ b ^ cin;
assign carry = (a & b) | (cin & b) | (cin & a);

endmodule
