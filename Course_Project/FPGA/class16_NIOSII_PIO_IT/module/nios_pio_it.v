module nios_pio_it(
	clk,
	rst,
	pio
);

inout [4:0]pio;
input clk,rst;



unsaved unsaved1 (
	.clk_clk(clk),
	.reset_reset_n(rst),
	.pio_export(pio)
);	

	
endmodule