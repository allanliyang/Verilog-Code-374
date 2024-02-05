module CSA_32bit (
	input [31:0]x, y, z,
	output [32:0]sum,
	output cout
	
);


wire[31:0] FAc, FAs, RCAc //Wires for: Full adder carries, Full adder sumns, Ripple Carry Portion Full adder carries

fulladder fa0(x[0], y[0], z[0], FAs[0], FAc[0])
fulladder fa1(x[1], y[1], z[1], FAs[1], FAc[1])
fulladder fa2(x[2], y[2], z[2], FAs[2], FAc[2])
fulladder fa3(x[3], y[3], z[3], FAs[3], FAc[3])
fulladder fa4(x[4], y[4], z[4], FAs[4], FAc[4])
fulladder fa5(x[5], y[5], z[5], FAs[5], FAc[5])
fulladder fa6(x[6], y[6], z[6], FAs[6], FAc[6])
fulladder fa7(x[7], y[7], z[7], FAs[7], FAc[7])
fulladder fa8(x[8], y[8], z[8], FAs[8], FAc[8])
fulladder fa9(x[9], y[9], z[9], FAs[9], FAc[9])
fulladder fa10(x[10], y[10], z[10], FAs[10], FAc[10])
fulladder fa11(x[11], y[11], z[11], FAs[11], FAc[11])
fulladder fa12(x[12], y[12], z[12], FAs[12], FAc[12])
fulladder fa13(x[13], y[13], z[13], FAs[13], FAc[13])
fulladder fa14(x[14], y[14], z[14], FAs[14], FAc[14])
fulladder fa15(x[15], y[15], z[15], FAs[15], FAc[15])
fulladder fa16(x[16], y[16], z[16], FAs[16], FAc[16])
fulladder fa17(x[17], y[17], z[17], FAs[17], FAc[17])
fulladder fa18(x[18], y[18], z[18], FAs[18], FAc[18])
fulladder fa19(x[19], y[19], z[19], FAs[19], FAc[19])
fulladder fa20(x[20], y[20], z[20], FAs[20], FAc[20])
fulladder fa21(x[21], y[21], z[21], FAs[21], FAc[21])
fulladder fa22(x[22], y[22], z[22], FAs[22], FAc[22])
fulladder fa23(x[23], y[23], z[23], FAs[23], FAc[23])
fulladder fa24(x[24], y[24], z[24], FAs[24], FAc[24])
fulladder fa25(x[25], y[25], z[25], FAs[25], FAc[25])
fulladder fa26(x[26], y[26], z[26], FAs[26], FAc[26])
fulladder fa27(x[27], y[27], z[27], FAs[27], FAc[27])
fulladder fa28(x[28], y[28], z[28], FAs[28], FAc[28])
fulladder fa29(x[29], y[29], z[29], FAs[29], FAc[29])
fulladder fa30(x[30], y[30], z[30], FAs[30], FAc[30])
fulladder fa31(x[31], y[31], z[31], FAs[31], FAc[31])

fulladder fa1_0(FAs[0], 1'b0, 1'b0, sum[0], RCAc[0])  // Dont know what the second parameter should be so just gave it 0
fulladder fa1_1(FAs[1], FAc[0], RCAc[0], sum[1], RCAc[1])
fulladder fa1_2(FAs[2], FAc[1], RCAc[1], sum[2], RCAc[2])
fulladder fa1_3(FAs[3], FAc[2], RCAc[2], sum[3], RCAc[3])
fulladder fa1_4(FAs[4], FAc[3], RCAc[3], sum[4], RCAc[4])
fulladder fa1_5(FAs[5], FAc[4], RCAc[4], sum[5], RCAc[5])
fulladder fa1_6(FAs[6], FAc[5], RCAc[5], sum[6], RCAc[6])
fulladder fa1_7(FAs[7], FAc[6], RCAc[6], sum[7], RCAc[7])
fulladder fa1_8(FAs[8], FAc[7], RCAc[7], sum[8], RCAc[8])
fulladder fa1_9(FAs[9], FAc[8], RCAc[8], sum[9], RCAc[9])
fulladder fa1_10(FAs[10], FAc[9], RCAc[9], sum[10], RCAc[10])
fulladder fa1_11(FAs[11], FAc[10], RCAc[10], sum[11], RCAc[11])
fulladder fa1_12(FAs[12], FAc[11], RCAc[11], sum[12], RCAc[12])
fulladder fa1_13(FAs[13], FAc[12], RCAc[12], sum[13], RCAc[13])
fulladder fa1_14(FAs[14], FAc[13], RCAc[13], sum[14], RCAc[14])
fulladder fa1_15(FAs[15], FAc[14], RCAc[14], sum[15], RCAc[15])
fulladder fa1_16(FAs[16], FAc[15], RCAc[15], sum[16], RCAc[16])
fulladder fa1_17(FAs[17], FAc[16], RCAc[16], sum[17], RCAc[17])
fulladder fa1_18(FAs[18], FAc[17], RCAc[17], sum[18], RCAc[18])
fulladder fa1_19(FAs[19], FAc[18], RCAc[18], sum[19], RCAc[19])
fulladder fa1_20(FAs[20], FAc[19], RCAc[19], sum[20], RCAc[20])
fulladder fa1_21(FAs[21], FAc[20], RCAc[20], sum[21], RCAc[21])
fulladder fa1_22(FAs[22], FAc[21], RCAc[21], sum[22], RCAc[22])
fulladder fa1_23(FAs[23], FAc[22], RCAc[22], sum[23], RCAc[23])
fulladder fa1_24(FAs[24], FAc[23], RCAc[23], sum[24], RCAc[24])
fulladder fa1_25(FAs[25], FAc[24], RCAc[24], sum[25], RCAc[25])
fulladder fa1_26(FAs[26], FAc[25], RCAc[25], sum[26], RCAc[26])
fulladder fa1_27(FAs[27], FAc[26], RCAc[26], sum[27], RCAc[27])
fulladder fa1_28(FAs[28], FAc[27], RCAc[27], sum[28], RCAc[28])
fulladder fa1_29(FAs[29], FAc[28], RCAc[28], sum[29], RCAc[29])
fulladder fa1_30(FAs[30], FAc[29], RCAc[29], sum[30], RCAc[30])
fulladder fa1_31(1'b0, FAc[30], RCAc[30], sum[31], cout)  // Might be passing the wrong FAc value


endmodule