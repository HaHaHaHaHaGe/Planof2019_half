transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/82312/Desktop/GitTEST/Planof2019_half/Course_Project/FPGA/class01_findstr/moudle {C:/Users/82312/Desktop/GitTEST/Planof2019_half/Course_Project/FPGA/class01_findstr/moudle/findstr.v}

vlog -vlog01compat -work work +incdir+C:/Users/82312/Desktop/GitTEST/Planof2019_half/Course_Project/FPGA/class01_findstr/testbench {C:/Users/82312/Desktop/GitTEST/Planof2019_half/Course_Project/FPGA/class01_findstr/testbench/findstr_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  findstr_tb

add wave *
view structure
view signals
run -all
