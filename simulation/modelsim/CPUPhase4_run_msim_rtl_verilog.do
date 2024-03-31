transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/Allan/Desktop/Verilog-Code-374-TEST {C:/Users/Allan/Desktop/Verilog-Code-374-TEST/register32bit.v}
vlog -vlog01compat -work work +incdir+C:/Users/Allan/Desktop/Verilog-Code-374-TEST {C:/Users/Allan/Desktop/Verilog-Code-374-TEST/R0.v}
vlog -vlog01compat -work work +incdir+C:/Users/Allan/Desktop/Verilog-Code-374-TEST {C:/Users/Allan/Desktop/Verilog-Code-374-TEST/MDR.v}
vlog -vlog01compat -work work +incdir+C:/Users/Allan/Desktop/Verilog-Code-374-TEST {C:/Users/Allan/Desktop/Verilog-Code-374-TEST/MAR.v}
vlog -vlog01compat -work work +incdir+C:/Users/Allan/Desktop/Verilog-Code-374-TEST {C:/Users/Allan/Desktop/Verilog-Code-374-TEST/Bus.v}
vlog -vlog01compat -work work +incdir+C:/Users/Allan/Desktop/Verilog-Code-374-TEST {C:/Users/Allan/Desktop/Verilog-Code-374-TEST/ALU.v}
vlog -vlog01compat -work work +incdir+C:/Users/Allan/Desktop/Verilog-Code-374-TEST {C:/Users/Allan/Desktop/Verilog-Code-374-TEST/SelectEncode.v}
vlog -vlog01compat -work work +incdir+C:/Users/Allan/Desktop/Verilog-Code-374-TEST {C:/Users/Allan/Desktop/Verilog-Code-374-TEST/ConFFLogic.v}
vlog -vlog01compat -work work +incdir+C:/Users/Allan/Desktop/Verilog-Code-374-TEST {C:/Users/Allan/Desktop/Verilog-Code-374-TEST/InPort.v}
vlog -vlog01compat -work work +incdir+C:/Users/Allan/Desktop/Verilog-Code-374-TEST {C:/Users/Allan/Desktop/Verilog-Code-374-TEST/ControlUnit.v}
vlog -vlog01compat -work work +incdir+C:/Users/Allan/Desktop/Verilog-Code-374-TEST {C:/Users/Allan/Desktop/Verilog-Code-374-TEST/Datapath.v}
vlog -vlog01compat -work work +incdir+C:/Users/Allan/Desktop/Verilog-Code-374-TEST {C:/Users/Allan/Desktop/Verilog-Code-374-TEST/RAM.v}

vlog -vlog01compat -work work +incdir+C:/Users/Allan/Desktop/Verilog-Code-374-TEST {C:/Users/Allan/Desktop/Verilog-Code-374-TEST/datapath_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclonev_ver -L cyclonev_hssi_ver -L cyclonev_pcie_hip_ver -L rtl_work -L work -voptargs="+acc"  datapath_tb

add wave *
view structure
view signals
run 10 us
