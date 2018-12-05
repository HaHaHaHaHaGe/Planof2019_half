module NCO(
	dac_sclk,
	dac_din,
	dac_csn,
	clk,
	rst
);


output dac_sclk,dac_din,dac_csn;
input clk,rst;

wire _rst;
wire _clk;
wire _norst;

PLL PLL1 (
	.areset(_norst),
	.inclk0(clk),
	.c0(_clk),
	.locked(_rst)
);

wire [11:0]data_1;
wire [11:0]data_2;
nco_test nco_test1 (
	.clk(_clk),
	.clken(_rst),
	.phi_inc_i(32'd429496),
	.freq_mod_i(32'd429496),
	.phase_mod_i(16'd65535),
	.fsin_o(data_1),
	.fcos_o(),
	.out_valid(),
	.reset_n(_rst)
);	


tlv5618a_device tlv5618a_device1(
	.DATA_A(data_2),
	.DATA_B(12'b010_0000),
	.clk(_clk),
	.rst(_rst),
	.dac_sclk(dac_sclk),
	.dac_din(dac_din),
	.dac_csn(dac_csn)
);


assign data_2 = data_1 + 12'd2048;


assign _norst = ~rst;

endmodule