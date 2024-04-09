<<<<<<< HEAD
module ClockDivider(

	output reg clockOut,
	input clockIn
);


reg [27:0]counter = 28'd0;
parameter DIVISOR = 28'd4; // f_clockOut = f_clockIn/DIVISOR

initial begin
	clockOut = 0;
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
		end
		else begin
			clockOut <= 1'b1;
		end
		
	end
	
end

endmodule
=======
module ClockDivider(

	output reg clockOut,
	input clockIn
);


reg [27:0]counter = 28'd0;
parameter DIVISOR = 28'd4; // f_clockOut = f_clockIn/DIVISOR

initial begin
	clockOut = 0;
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
		end
		else begin
			clockOut <= 1'b1;
		end
	end	
end

endmodule
>>>>>>> abf1946135971059fde38dd2cf2c5c04262bbd51
