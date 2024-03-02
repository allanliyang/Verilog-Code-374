module RAM(Cs_b, We_b, Oe_b, Addrress, IO); 
	input Cs_b;					//chip select 
	input We_b;					//write enable/ read enable 
	input Oe_b;					// output enable; 
	input[8:0] Address; 		// address input 
	inout[31:0] IO;
	
	reg[8:0] mem[0:511];  //2^9 
	
	assign IO = ((Cs_b == 1'b1 | We_b == 1'b1 | Oe_b == 1'b1) ? 
		9'bZ: mem[Address]; //read from RAM
	always @(We_b, Cs_b) 
	begin 
		@(negedge We_b) // falling edge of We_b 
		if(Cs_b == 1'b0)
		begin
		mem[Address] <= I0;  //write to RAM
		end 
	end 
	endmodule 
		
		
