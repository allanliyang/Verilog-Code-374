// T0: PCout, MARin, IncPC, Zin
// T1: Zlowout, PCin, MDMuxread, Mdatain, MDRin
// T2: MDRout, IRin
// T3: Gra, Rout, CONin
// T4: PCout, Yin
// T5: Cout, ADD, Zlowin
// T6: Zlowout, if(CONFF) then CON -> PCin

// functionality
  // this tb performs
  // case 1 : brzr R5, 14 (branch if zero)
  // case 2 : brnz R5, 14 (branch if nonzero, i.e. positive or negative)
  // case 3 : brpl R5, 14 (branch if positive)
  // case 4 : brmi R5, 14 (branch if negative)


`timescale 1ns/10ps
module datapath_tb_BR);
