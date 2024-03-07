// temporary testbench used to verify functionality of ram separate from other components
// ram is confirmed working
`timescale 1ns/10ps
module ram_tb();

  reg read, write;
  reg [8:0]address;
  reg [31:0]BusMuxOut;
  
  wire [31:0]Mdatain;

  RAM RAM(read, write, address, BusMuxOut, Mdatain);
  
  
  
  reg clock;
  reg [3:0]Present_state;
  integer i;


initial begin clock = 0; Present_state = 4'b0000; end
always #10 clock = ~clock;
always @ (negedge clock) Present_state = Present_state + 1;

always @ (Present_state) begin

		case (Present_state)
			4'b0001 : begin
				read <= 1; write <= 0; address <= 9'b000000000;
				#15 read <= 0;
			end
			
			4'b0010 : begin
				read <= 0; write <= 1; address <= 9'b000000001; BusMuxOut <= 32'hFFFFFFFF;
				#15 write <= 0; BusMuxOut <= 32'b0;
			end
			
			4'b0011 : begin
				read <= 1; write <= 0; address <= 9'b000000001;
				#15 read <= 0;
			end
			
			4'b0100 : begin
				read <= 1; write <= 0; address <= 9'b000000001;
				#15 read <= 0;
			end
			
			4'b0101 : begin
				read <= 1; write <= 0; address <= 9'b000000000;
				#15 read <= 0;
			end
		endcase
			
end

endmodule
