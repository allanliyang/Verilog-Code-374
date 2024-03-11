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
		// $readmemh("C:/Users/Allan/Desktop/Verilog-Code-374 TEST/512x0.txt", mem, 0, 511); // WARNING: UPDATE PATH BEFORE RUNNING
		
		// datapath_tb_LD
		// $readmemh("C:/Users/Allan/Desktop/Verilog-Code-374 TEST/ram_LD.txt", mem, 0, 511); // WARNING: UPDATE PATH BEFORE RUNNING
		
		// datapath_tb_LDI
		// $readmemh("C:/Users/Allan/Desktop/Verilog-Code-374 TEST/ram_LDI.txt", mem, 0, 511); // WARNING: UPDATE PATH BEFORE RUNNING
		
		// datapath_tb_ST
		// $readmemh("C:/Users/Allan/Desktop/Verilog-Code-374 TEST/ram_ST.txt", mem, 0, 511); // WARNING: UPDATE PATH BEFORE RUNNING
		
		// datapath_tb_ADDI
		// $readmemh("C:/Users/Allan/Desktop/Verilog-Code-374 TEST/ram_ADDI.txt", mem, 0, 511); // WARNING: UPDATE PATH BEFORE RUNNING
		
		// datapath_tb_ANDI
		// $readmemh("C:/Users/Allan/Desktop/Verilog-Code-374 TEST/ram_ANDI.txt", mem, 0, 511); // WARNING: UPDATE PATH BEFORE RUNNING
		
		// datapath_tb_ORI
		// $readmemh("C:/Users/Allan/Desktop/Verilog-Code-374 TEST/ram_ORI.txt", mem, 0, 511); // WARNING: UPDATE PATH BEFORE RUNNING
		
		// datapath_tb_BRZR
		// $readmemh("C:/Users/Allan/Desktop/Verilog-Code-374 TEST/ram_BRZR.txt", mem, 0, 511); // WARNING: UPDATE PATH BEFORE RUNNING
		
		// datapath_tb_BRNZ
		// $readmemh("C:/Users/Allan/Desktop/Verilog-Code-374 TEST/ram_BRNZ.txt", mem, 0, 511); // WARNING: UPDATE PATH BEFORE RUNNING
		
		// datapath_tb_BRPL
		// $readmemh("C:/Users/Allan/Desktop/Verilog-Code-374 TEST/ram_BRPL.txt", mem, 0, 511); // WARNING: UPDATE PATH BEFORE RUNNING
		
		// datapath_tb_BRMI
		$readmemh("C:/Users/Allan/Desktop/Verilog-Code-374 TEST/ram_BRMI.txt", mem, 0, 511); // WARNING: UPDATE PATH BEFORE RUNNING
		
		// datapath_tb_JUMP
		// $readmemh("C:/Users/Allan/Desktop/Verilog-Code-374 TEST/ram_JUMP.txt", mem, 0, 511); // WARNING: UPDATE PATH BEFORE RUNNING
		
		// datapath_tb_MFHILO
		// $readmemh("C:/Users/Allan/Desktop/Verilog-Code-374 TEST/ram_MFHILO.txt", mem, 0, 511); // WARNING: UPDATE PATH BEFORE RUNNING
		
		// datapath_tb_INOUT
		// $readmemh("C:/Users/Allan/Desktop/Verilog-Code-374 TEST/ram_INOUT.txt", mem, 0, 511); // WARNING: UPDATE PATH BEFORE RUNNING
		
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
				$writememh("C:/Users/Allan/Desktop/Verilog-Code-374 TEST/RAMoutput.txt", mem, 0, 511); // WARNING: UPDATE PATH BEFORE RUNNING
			end
			
	end
	
assign Mdatain = data;
	
endmodule 
