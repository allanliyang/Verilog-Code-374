module RAM(
	input read, write,
	input [8:0]address,
	input [31:0]BusMuxOut,
	output wire [31:0]Mdatain // check if this should be reg?
	);

	reg [31:0]mem[0:511];  // 36x512 RAM
	reg [31:0]data;

	initial begin
		
		// uncomment the appropriate txt file to initialize ram for each testbench
		
		// default case
		// $readmemh("D:/Verilog-Code-374/512x0.txt", mem, 0, 511); // WARNING: UPDATE PATH BEFORE RUNNING
		
		// datapath_tb_LD
		// $readmemh("D:/Verilog-Code-374/ram_LD.txt", mem, 0, 511); // WARNING: UPDATE PATH BEFORE RUNNING
		
		// datapath_tb_LDI
		// $readmemh("D:/Verilog-Code-374/ram_LDI.txt", mem, 0, 511); // WARNING: UPDATE PATH BEFORE RUNNING
		
		// datapath_tb_ST
		// $readmemh("D:/Verilog-Code-374/ram_ST.txt", mem, 0, 511); // WARNING: UPDATE PATH BEFORE RUNNING
		
		// datapath_tb_ADDI
		// $readmemh("D:/Verilog-Code-374/ram_ADDI.txt", mem, 0, 511); // WARNING: UPDATE PATH BEFORE RUNNING
		
		// datapath_tb_ANDI
		// $readmemh("D:/Verilog-Code-374/ram_ANDI.txt", mem, 0, 511); // WARNING: UPDATE PATH BEFORE RUNNING
		
		// datapath_tb_ORI
		// $readmemh("D:/Verilog-Code-374/ram_ORI.txt", mem, 0, 511); // WARNING: UPDATE PATH BEFORE RUNNING
		
		// datapath_tb_BRZR
		// $readmemh("D:/Verilog-Code-374/ram_BRZR.txt", mem, 0, 511); // WARNING: UPDATE PATH BEFORE RUNNING
		
		// datapath_tb_BRNZ
		// $readmemh("D:/Verilog-Code-374/ram_BRNZ.txt", mem, 0, 511); // WARNING: UPDATE PATH BEFORE RUNNING
		
		// datapath_tb_BRPL
		// $readmemh("D:/Verilog-Code-374/ram_BRPL.txt", mem, 0, 511); // WARNING: UPDATE PATH BEFORE RUNNING
		
		// datapath_tb_BRMI
		// $readmemh("D:/Verilog-Code-374/ram_BRMI.txt", mem, 0, 511); // WARNING: UPDATE PATH BEFORE RUNNING
		
		// datapath_tb_JUMP
		// $readmemh("D:/Verilog-Code-374/ram_JUMP.txt", mem, 0, 511); // WARNING: UPDATE PATH BEFORE RUNNING
		
		// datapath_tb_MFHILO
		// $readmemh("D:/Verilog-Code-374/ram_MFHILO.txt", mem, 0, 511); // WARNING: UPDATE PATH BEFORE RUNNING
		
		// datapath_tb_INOUT
		// $readmemh("D:/Verilog-Code-374/ram_INOUT.txt", mem, 0, 511); // WARNING: UPDATE PATH BEFORE RUNNING
		
	end
	
	// output from ram when read == 1 and write == 0
	always @ (address, read, write) begin 
			
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
				mem[address] = BusMuxOut;
				// update text file to reflect ram contents
				$writememh("D:/Verilog-Code-374/RAMoutput.txt", mem, 0, 511); // WARNING: UPDATE PATH BEFORE RUNNING
			end
			
	end
	
assign Mdatain = data;
	
endmodule 
