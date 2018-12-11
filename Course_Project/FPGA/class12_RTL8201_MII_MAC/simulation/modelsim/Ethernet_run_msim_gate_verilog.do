transcript on
if {[file exists gate_work]} {
	vdel -lib gate_work -all
}
vlib gate_work
vmap work gate_work

vlog -vlog01compat -work work +incdir+. {Ethernet_8_1200mv_85c_slow.vo}

vlog -vlog01compat -work work +incdir+C:/Users/Administrator/Desktop/github_code/Planof2019_half/Course_Project/FPGA/class12_RTL8201_MII_MAC/testbench {C:/Users/Administrator/Desktop/github_code/Planof2019_half/Course_Project/FPGA/class12_RTL8201_MII_MAC/testbench/arp_test_tb.v}

vsim -t 1ps +transport_int_delays +transport_path_delays -L altera_ver -L cycloneive_ver -L gate_work -L work -voptargs="+acc"  arp_test_tb

add wave *
view structure
view signals
run -all
