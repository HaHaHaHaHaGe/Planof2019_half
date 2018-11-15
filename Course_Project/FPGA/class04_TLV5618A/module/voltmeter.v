module voltmeter(
	key1,
	key2,
	rst,
	clk,
	lock595,
	out595,
	clk595,
	adc_sclk,
	adc_saddr,
	adc_csn,
	adc_sdat,
	dac_sclk,
	dac_din,
	dac_csn
);
input clk,rst,key1,key2,adc_sdat;
wire [2:0]out;
output lock595,out595,clk595,adc_sclk,adc_csn,adc_saddr,dac_sclk,dac_din,dac_csn;
wire [11:0]data;
wire BUSY;
reg START;
wire oclk;
wire [11:0]DATA_A;
wire [11:0]DATA_B;
frequencydivider frequencydivider1(
	.clk(clk),
	.rst(rst),
	.fclk(oclk)
);
KEY_Selector KEY_Selector1(
	.key1(key1),
	.key2(key2),
	.clk(clk),
	.rst(rst),
	.out(out)
);
BCDDisplay BCDDisplay1(
	.clk(clk),
	.rst(rst),
	.data({1'b0,out,16'b0,data}),
	.lock595(lock595),
	.out595(out595),
	.clk595(clk595)
);
ADC128S022_interface ADC128S022_interface1(
	.ADDR(out),
	.DATA(data),
	.START(START),
	.BUSY(BUSY),
	.CLK(oclk),
	.RST(rst),
	.adc_sclk(adc_sclk),
	.adc_saddr(adc_saddr),
	.adc_csn(adc_csn),
	.adc_sdat(adc_sdat)
);
tlv5618a_device tlv5618a_device1(
	.DATA_A(DATA_A),
	.DATA_B(DATA_B),
	.clk(oclk),
	.rst(rst),
	.dac_sclk(dac_sclk),
	.dac_din(dac_din),
	.dac_csn(dac_csn)
);
always@(posedge oclk)
if(BUSY)
	START <= 1'b0;
else
	START <= 1'b1;	
assign DATA_A = 12'h0e4;
assign DATA_B = 12'hfff;

endmodule
