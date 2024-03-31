transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+D:/Verilog-Code-374 {D:/Verilog-Code-374/register32bit.v}
vlog -vlog01compat -work work +incdir+D:/Verilog-Code-374 {D:/Verilog-Code-374/R0.v}
vlog -vlog01compat -work work +incdir+D:/Verilog-Code-374 {D:/Verilog-Code-374/MDR.v}
vlog -vlog01compat -work work +incdir+D:/Verilog-Code-374 {D:/Verilog-Code-374/MAR.v}
vlog -vlog01compat -work work +incdir+D:/Verilog-Code-374 {D:/Verilog-Code-374/InPort.v}
vlog -vlog01compat -work work +incdir+D:/Verilog-Code-374 {D:/Verilog-Code-374/ALU.v}
vlog -vlog01compat -work work +incdir+D:/Verilog-Code-374 {D:/Verilog-Code-374/SelectEncode.v}
vlog -vlog01compat -work work +incdir+D:/Verilog-Code-374 {D:/Verilog-Code-374/ConFFLogic.v}
vlog -vlog01compat -work work +incdir+D:/Verilog-Code-374 {D:/Verilog-Code-374/Datapath.v}
vlog -vlog01compat -work work +incdir+D:/Verilog-Code-374 {D:/Verilog-Code-374/ControlUnit.v}
vlog -vlog01compat -work work +incdir+D:/Verilog-Code-374 {D:/Verilog-Code-374/Bus.v}
vlog -vlog01compat -work work +incdir+D:/Verilog-Code-374 {D:/Verilog-Code-374/RAM.v}

vlog -vlog01compat -work work +incdir+D:/Verilog-Code-374 {D:/Verilog-Code-374/datapath_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclonev_ver -L cyclonev_hssi_ver -L cyclonev_pcie_hip_ver -L rtl_work -L work -voptargs="+acc"  datapath_tb

add wave *
view structure
view signals
run 10 us
