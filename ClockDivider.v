module ClockDivider(

	output reg clockOut,
	output reg clearCU,
	input clockIn
);


reg [27:0]counter = 28'd0;
parameter DIVISOR = 28'd4; // f_clockOut = f_clockIn/DIVISOR
reg flag = 1'b0; // used to check is CU needs to be cleared
reg temp = 1'b0;

initial begin
	clockOut = 0;
	clearCU <= 0;
end

always @ (clockIn) begin
	
	if (clockIn) begin
		// increment counter
		counter <= counter + 1;
	
		// check if counter has reached  length on new clock cycle
		// 	i.e. 1 new clock cycle = 5 original clock cycles
		if (counter >= (DIVISOR-1)) begin
			// reset counter
			counter <= 28'd0;
		end

		// set clockOut equal to 
		if (counter < (DIVISOR/2)) begin
		
			clockOut <= 1'b0;
			
			flag <= 1'b0;
			clearCU <= 0;
			
		
		end
	
		else begin
			clockOut <= 1'b1;
			
			
			if (counter >= (DIVISOR/2)) begin
				flag <= 1'b1; // start checking to clear CU at next negedge
			end
			else begin 
				flag <= 1'b0;
				//clearCU <= 1'b0;
			end
		end
	end
	
	if (!clockIn && flag) begin
	
		clearCU <= 1'b1;
		
	end
	
end

endmodule
