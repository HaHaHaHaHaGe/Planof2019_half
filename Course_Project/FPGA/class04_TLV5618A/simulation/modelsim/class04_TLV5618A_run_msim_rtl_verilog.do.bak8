transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/82312/Desktop/GitTEST/Planof2019_half/Course_Project/FPGA/class04_TLV5618A/module {C:/Users/82312/Desktop/GitTEST/Planof2019_half/Course_Project/FPGA/class04_TLV5618A/module/tlv5618a_interface.v}
vlog -vlog01compat -work work +incdir+C:/Users/82312/Desktop/GitTEST/Planof2019_half/Course_Project/FPGA/class04_TLV5618A/module {C:/Users/82312/Desktop/GitTEST/Planof2019_half/Course_Project/FPGA/class04_TLV5618A/module/tlv5618a_device.v}

vlog -vlog01compat -work work +incdir+C:/Users/82312/Desktop/GitTEST/Planof2019_half/Course_Project/FPGA/class04_TLV5618A/testbench {C:/Users/82312/Desktop/GitTEST/Planof2019_half/Course_Project/FPGA/class04_TLV5618A/testbench/tlv5618a_device_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  tlv5618a_device_tb

add wave *
view structure
view signals
run -all
