transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+D:/ELEC374/Tutorial {D:/ELEC374/Tutorial/RCAdd.v}
vlog -vlog01compat -work work +incdir+D:/ELEC374/Tutorial {D:/ELEC374/Tutorial/ETRegister.v}
vlog -vlog01compat -work work +incdir+D:/ELEC374/Tutorial {D:/ELEC374/Tutorial/BDBus.v}
vlog -vlog01compat -work work +incdir+D:/ELEC374/Tutorial {D:/ELEC374/Tutorial/Datapath.v}

vlog -vlog01compat -work work +incdir+D:/ELEC374/Tutorial {D:/ELEC374/Tutorial/tutorial_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclonev_ver -L cyclonev_hssi_ver -L cyclonev_pcie_hip_ver -L rtl_work -L work -voptargs="+acc"  tutorial_tb

add wave *
view structure
view signals
run 80 ns
