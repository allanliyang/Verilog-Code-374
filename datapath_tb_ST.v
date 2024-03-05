// T0: PCout, MARin, IncPC, Zin                 (PC+1 -> Z, PC -> MAR(Addr -> RAM))
// T1: Zlowout, PCin, MDMuxread, Mdatain, MDRin (Z -> PC, RAM@Addr -> MDR)
// T2: MDRout, IRin                             (MDR(from RAM) -> IR)
// T3: Grb, BAout, Yin                          (Rb -> Y)
// T4: Cout, ADD, Zin                           (Y+C -> Z)
// T5: Zlowout, MARin                           (Z -> MAR(Addr -> RAM))
// T6: Gra, Rout, RAMwrite                      (Ra -> RAM@Addr)

// testbench for LD instruction
// NOTE: FIX TESTBENCH SETTINGS BEFORE RUNNING THIS

// functionality
  // this tb performs st 0x87, R1 and st 0x87(R1), R1

`timescale 1ns/10ps
module datapath_tb_ST();

  
