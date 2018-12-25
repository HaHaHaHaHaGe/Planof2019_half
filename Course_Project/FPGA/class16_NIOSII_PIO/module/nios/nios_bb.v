
module nios (
	clk_clk,
	led_export,
	rst_reset_n);	

	input		clk_clk;
	inout	[4:0]	led_export;
	input		rst_reset_n;
endmodule
