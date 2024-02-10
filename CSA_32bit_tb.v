`timescale 1ns/10ps 

module CSA_32bit_tb();

    // Inputs
    reg [31:0] x, y, z;
    
    // Outputs
    wire [32:0] sum;
    wire cout;
    
    // Instantiate the DUT (device under test)
    CSA_32bit dut (x,y,z,sum,cout);
    
    // Test logic
    initial begin
        // Initialize inputs
        x = 32'h00000010;
        y = 32'h00000008;
        z = 32'h00000001;
        
        // Apply stimulus
        #10; // Wait for 10 time units
        
        // Display inputs
        $display("Inputs: x = %h, y = %h, z = %h", x, y, z);
        
        // Wait for additional time
        #10;
        
        // Display outputs
        $display("Outputs: sum = %h, cout = %b", sum, cout);
        
        // End simulation
        $finish;
    end
    
endmodule