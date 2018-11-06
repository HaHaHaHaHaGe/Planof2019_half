`timescale 1ns/1ns
`define time_per 10

module findstr_tb;
	reg clk;
	reg rst_n;
	reg dv;
	reg [7:0]data;
	
	wire [3:0]num;
	wire get_flag;

	reg [511:0] data_tmp;
	findstr findstr_1(
			.clk(clk),
			.rst_n(rst_n),
			.dv(dv),
			.data(data),
			.num(num),
			.get_flag(get_flag)
	);
	
	initial data_tmp = "amgnawuiWelWelcomcomerighwelcomhbhhflalWelcomilrbgfvWelcomlailulwblsirudwelcomguufujijlawWelcomiurg";

	initial begin
	clk = 0;
	rst_n = 0;
	dv = 0;
	data = 0;
	end
	
	always #10 clk = ~clk;
	always #20 begin 
		data = data_tmp[511:504];
		data_tmp = data_tmp << 8;
	end
	
	initial begin
	#10;
	rst_n = 1;
	dv = 1;
	#10000;
	$stop;
	
	end
	

endmodule