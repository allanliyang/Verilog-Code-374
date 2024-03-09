// T0: PCout, MARin, IncPC, Zlowin                           (PC+1 -> Z, PC -> MAR(Addr -> RAM))
// T1: Zlowout, PCin, MDMuxread, RAMread, Mdatain, MDRin     (Z -> PC, RAM@Addr -> MDR)
// T2: MDRout, IRin                                          (MDR(from RAM) -> IR)
// T3: Grb, BAout, Yin                                       (Rb -> Y)
// T4: CSEout, ADD, Zlowin                                   (Y+C -> Z)
// T5: Zlowout, MARin                                        (Z -> MAR(Addr -> RAM))
// T6: Gra, Rout, RAMwrite                                   (Ra -> RAM@Addr)

// testbench for LD instruction
// NOTE: FIX TESTBENCH SETTINGS BEFORE RUNNING THIS

// functionality
  // this tb performs st 0x87, R1 and then st 0x87(R1), R1
  // before the ST instructions are run, ldi R1, 0x43 is used to store 0x43 in R1
  // after 'st 0x87, R1', R1(0x43) will be stored in at ram address 0x87(d135)
  // 0x87 + 0x43 = 0xCA
  // after 'st 0x87(R1), R1', R1(0x43) will be stored at ram address 0xCA(d202)

// equivalent asm code
  // ldi R1, 0x43
  // st 0x87, R1
  // st 0x87(R1), R1


`timescale 1ns/10ps
module datapath_tb_ST();

  // reg declarations
	reg clear, clock;
	reg HIin, LOin, HIout, LOout;
	reg Zhighin, Zlowin, Zhighout, Zlowout;
	reg PCin, PCout;
	reg MDRin, MDRout, MARin;
	reg InPortout, OutPortin;
	reg CSEout;
	reg IRin;
	reg MDMuxread;
	reg Yin;
	reg ADD, SUB, MUL, DIV;
	reg AND, OR;
	reg SHR, SHRA, SHL;
	reg ROR, ROL;
	reg NEG, NOT;
	reg IncPC;
	reg Gra, Grb, Grc;
	reg Rin, Rout, BAout;
	reg [31:0]InPortdata;
	reg RAMread, RAMwrite;
	reg CONin;
	
	// outputs from datapath
	wire [31:0]OutPortdata;
	wire ConFFQ;

	
	reg [4:0]Present_state = 4'b00000;

	
	Datapath DUT 	(clear, clock,
						HIin, LOin, HIout, LOout,
						Zhighin, Zlowin, Zhighout, Zlowout,
						PCin, PCout,
						MDRin, MDRout, MARin,
						InPortout, OutPortin,
						CSEout,
						IRin,
						MDMuxread,
						Yin,
						ADD, SUB, MUL, DIV,
						AND, OR,
						SHR, SHRA, SHL,
						ROR, ROL,
						NEG, NOT, 
						IncPC,
						Gra, Grb, Grc,
						Rin, Rout, BAout,
						InPortdata,
						RAMread, RAMwrite,
			 			CONin,
						OutPortdata,
						ConFFQ);


	initial begin clock = 0; Present_state = 4'b0000; end
	always #10 clock = ~clock;
	always @ (negedge clock) Present_state = Present_state + 1;


	always @ (Present_state) begin
	
			case (Present_state)
					
					5'b00001 : begin 	// default case, clear registers and set all signals to low
						clear <= 1;
						PCin <= 0;		PCout <= 0;
						Zlowin <= 0;	Zlowout <= 0;
						MDRin <= 0; 	MDRout <= 0;	MDMuxread <= 0;	MARin <= 0;
						CSEout <= 0;
						IRin <= 0;
						Yin <= 0;
						IncPC <= 0;		ADD <= 0;
						Gra <= 0; 		Grb <= 0; 		Grc <= 0;
						Rin <= 0; 		Rout <= 0; 		BAout <= 0;
						RAMread <= 0;	RAMwrite <= 0;

						#15 clear <= 0;
					end

					// ldi R1, 0x43 to preload register R1
					5'b00010 : begin	// LDI T0: PCout, MARin, IncPC, Zlowin
						PCout <= 1;		MARin <= 1;		IncPC <= 1;		Zlowin <= 1;
						#15 PCout <= 0; MARin <= 0; IncPC <= 0; Zlowin <= 0;
					end
					
					5'b00011 : begin	// LDI T1: Zlowout, PCin, MDMuxread, RAMread, Mdatain, MDRin
						Zlowout <= 1; 		PCin <= 1; 	MDMuxread <= 1; RAMread <= 1; MDRin <= 1;
						#15 Zlowout <= 0; PCin <= 0; 	MDMuxread <= 0; RAMread <= 0; MDRin <= 0;
					end
					
					5'b00100 : begin	// LDI T2: MDRout, IRin
						MDRout <= 1; IRin <= 1;
						#15 MDRout <= 0; IRin <= 0;
					end
					
					5'b00101 : begin	// LDI T3: Grb, BAout, Yin
						Grb <= 1; BAout <= 1; Yin <= 1;
						#15 Grb <= 0; BAout <= 0; Yin <= 0;
					end
					
					5'b00110 : begin	// LDI T4: CSEout, ADD, Zlowin
						CSEout <= 1; ADD <= 1; Zlowin <= 1;
						#15 CSEout <= 0; ADD <= 0; Zlowin <= 0;
					end 
					
					5'b00111 : begin	// LDI T5: Zlowout, Gra, Rin
						Zlowout <= 1; Gra <= 1; Rin <= 1;
						#15 Zlowout <= 0; Gra <= 0; Rin <= 0;
					end

					// ST control sequences start here
					// st 0x87, R1
					5'b01000 : begin	// T0: PCout, MARin, IncPC, Zlowin
						PCout <= 1;		MARin <= 1;		IncPC <= 1;		Zlowin <= 1;
						#15 PCout <= 0; MARin <= 0; IncPC <= 0; Zlowin <= 0;
					end
					
					5'b01001 : begin	// T1: Zlowout, PCin, MDMuxread, RAMread, Mdatain, MDRin 
						Zlowout <= 1; 		PCin <= 1; 	MDMuxread <= 1; RAMread <= 1; MDRin <= 1;
						#15 Zlowout <= 0; PCin <= 0; 	MDMuxread <= 0; RAMread <= 0; MDRin <= 0;
					end
					
					5'b01010 : begin 	// T2: MDRout, IRin 
						MDRout <= 1; IRin <= 1;
						#15 MDRout <= 0; IRin <= 0;
					end
					
					5'b01011 : begin	// T3: Grb, BAout, Yin
						Grb <= 1; BAout <= 1; Yin <= 1;
						#15 Grb <= 0; BAout <= 0; Yin <= 0;
					end
					
					5'b01100 : begin	// T4: CSEout, ADD, Zlowin
						CSEout <= 1; ADD <= 1; Zlowin <= 1;
						#15 CSEout <= 0; ADD <= 0; Zlowin <= 0;
					end
					
					5'b01101 : begin	// T5: Zlowout, MARin
						Zlowout <= 1; MARin <= 1;
						#15 Zlowout <= 0; MARin <= 0;
					end
					
					5'b01110 : begin	// T6: Gra, Rout, RAMwrite
						Gra <= 1; Rout <= 1; RAMwrite <= 1;
						#15 Gra <= 0; Rout <= 0; RAMwrite <= 0;
					end

					// st 0x87(R1), R1
					5'b01111 : begin	// T0: PCout, MARin, IncPC, Zlowin
						PCout <= 1;		MARin <= 1;		IncPC <= 1;		Zlowin <= 1;
						#15 PCout <= 0; MARin <= 0; IncPC <= 0; Zlowin <= 0;
					end
					
					5'b10000 : begin	// T1: Zlowout, PCin, MDMuxread, RAMread, Mdatain, MDRin
						Zlowout <= 1; 		PCin <= 1; 	MDMuxread <= 1; RAMread <= 1; MDRin <= 1;
						#15 Zlowout <= 0; PCin <= 0; 	MDMuxread <= 0; RAMread <= 0; MDRin <= 0;
					end

					5'b10001 : begin	// T2: MDRout, IRin
						MDRout <= 1; IRin <= 1;
						#15 MDRout <= 0; IRin <= 0;
					end

					5'b10010 : begin  // T3: Grb, BAout, Yin
						Grb <= 1; BAout <= 1; Yin <= 1;
						#15 Grb <= 0; BAout <= 0; Yin <= 0;
          end

          5'b10011 : begin  // T4: CSEout, ADD, Zlowin
						CSEout <= 1; ADD <= 1; Zlowin <= 1;
						#15 CSEout <= 0; ADD <= 0; Zlowin <= 0;
          end

          5'b10100 : begin  // T5: Zlowout, MARin
            Zlowout <= 1; MARin <= 1;
            #15 Zlowout <= 0; MARin <= 0;
          end

          5'b10101 : begin  // T6: Gra, Rout, RAMwrite
            Gra <= 1; Rout <= 1; RAMwrite <= 1;
            #15 Gra <= 0; Rout <= 0; RAMwrite <= 0;
          end
        
			endcase
    
	end
  
endmodule
