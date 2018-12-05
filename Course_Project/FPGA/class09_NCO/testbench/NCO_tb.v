`timescale 1ns/1ns
module NCO_tb();


wire dac_sclk,dac_din,dac_csn;
reg clk,rst;

NCO NCO1(
	.dac_sclk(dac_sclk),
	.dac_din(dac_din),
	.dac_csn(dac_csn),
	.clk(clk),
	.rst(rst)
);


initial begin
clk <= 0;
rst <=1;
end


always #10 clk <= ~clk;

initial begin
#100;
rst <= 0;
#100;
rst <=1;
#100000000;
end


endmodule