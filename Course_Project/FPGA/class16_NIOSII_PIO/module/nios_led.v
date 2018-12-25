module nios_led(
	rst,
	clk,
	led

);

input rst,clk;
inout [4:0]led;

nios u0 (
	.clk_clk(clk),
	.rst_reset_n(rst),
	.led_export(led)
);
endmodule
