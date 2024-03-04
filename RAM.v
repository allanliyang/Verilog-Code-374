module RAM(We_b, Re_b, Addrress, IO); 
	input We_b;					//write enable
	input Re_b;					//Read enable; 
	input[8:0] Address; 				// address input 
	input[31:0]BusMuxIn; 
	output[31:0]MDRMux; 

	
	reg[8:0] mem[0:511];  // RAM, 2^9 
	reg[8:0] data; 
	
	
	//Read to RAM When We = 0 and Re = 1 
	always @(Address or We_b or Re_b) 
		begin 
			if(Re_b && !We_b)
				data <= mem[Address]; 
		end 
	// Write to RAM	
	always @( Address or IO or We_b) 
		begin 
			if(We_b == 1'b1)
			mem[Address] <= IO; 
		end 
	assign MDRMux = data; 
	endmodule 
		
		

