module RAM(
	input read, write,
	input [8:0]address,
	input [31:0]BusMuxOut, 
	output[31:0]Mdatain
	);

	
	reg[31:0] mem[0:511];  // 36x512 RAM
	reg[31:0] data;
	
	// output from ram when read == 1 and write == 0
	always @ (address, write, read) begin 
			if(read && !write) begin
				data <= mem[address];
			end
			else begin
				data <= 32'hZZZZZZZZ;
			end
	end 
	
	// write to ram when write == 1
	always @ (address, BusMuxOut, write) begin 
			if (write) begin 
				mem[address] <= BusMuxOut; 
			end
			
	end
	
assign Mdatain = data;
	
endmodule 
	