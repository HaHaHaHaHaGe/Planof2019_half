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
	adc_sdat
);
input clk,rst,key1,key2,adc_sdat;
wire [2:0]out;
output lock595,out595,clk595,adc_sclk,adc_csn,adc_saddr;
wire [11:0]data;

wire BUSY;
reg START;
wire oclk;

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

always@(posedge oclk)
if(BUSY)
	START <= 1'b0;
else
	START <= 1'b1;

endmodule