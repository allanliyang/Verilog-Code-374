// temporary testbench used to verify functionality of ram separate from other components

module ram_tb();

  reg read, write;
  reg [8:0]address;
  reg [31:0]BusMuxOut, Mdatain;

  ram(read, write, address, BusMuxOut, Mdatain);
  
  integer i;

  initial begin

    read = 1;
    write = 0;
    address = 9'b0;
  
    // display first 40 entries of RAM
    $display("First 40 RAM entries");
    for (i = 0; i < 40; i = i+1) begin
      $display("%h", Mdatain);
      address = address + 1;
      #10
    end
    
    read = 0;
    address = 0;
    BusMuxOut = 32'h0;
    write = 1;
    // rewrite first 40 entries to 0x0
    $display("Editing RAM");
    for (i = 0; i < 40; i = i+1) begin
      address = address + 1;
      BusMuxOut = BusMuxOut + 1;
      #10
    end

    write = 0;
    read = 1;
    address = 9'b0;
    
    // display first 40 entries of RAM
    $display("Edited 40 RAM entries");
    for (i = 0; i < 40; i = i+1) begin
      $display("%h", Mdatain);
      address = address + 1;
      #10
    end
    
  end

endmodule
