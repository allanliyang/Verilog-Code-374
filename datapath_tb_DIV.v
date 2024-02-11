// T0 : PCout, MARin, IncPC, Zlowin
// T1 : Zlowout, PCin, MDMuxread, Mdatain, MDRin
// T2 : MDRout, IRin
// T3 : R4out, Yin
// T4 : R5out, DIV, Zlowin, Zhighin
// T5 : Zlowout, LOin
// T6	: Zhighout, HIin

// testbench for MUL instruction
// NOTE: FIX TESTBENCH SETTINGS BEFORE RUNNING THIS

// functionality:
  // this TB performs MUL R4, R5, results will be stored in HI and LO registers
  // with R4 = 1111 1111 1111 1111 1111 1111 1100 1011 (0xFFFFFFCB or -53)
  // with R5 = 1111 1111 1111 1111 1111 1111 1100 0010 (0xFFFFFFC2 or -62)
  // and LO expected = 1100 1101 0110 (0x00000CD6 or 3286)
  // and HI expected = 0