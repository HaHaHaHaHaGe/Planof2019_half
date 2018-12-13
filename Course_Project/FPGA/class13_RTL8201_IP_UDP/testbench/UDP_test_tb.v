`timescale 1ns/1ns
module UDP_test_tb();



reg clk,rst,ETH_TX_CLK;
wire ETH_TX_EN,ETH_RST_N;
wire [3:0]ETH_TX_DATA;
UDP_test UDP_test(
	.clk(clk),
	.rst(rst),
	
	.ETH_TX_EN(ETH_TX_EN),
	.ETH_TX_CLK(ETH_TX_CLK),
	.ETH_TX_DATA(ETH_TX_DATA),
	.ETH_RST_N(ETH_RST_N)
);


initial begin
	clk <=0;
	rst <=1;
	ETH_TX_CLK <=0;
end


always #10 clk <= ~clk;
always #22 ETH_TX_CLK <= ~ETH_TX_CLK;


initial begin
#100;
rst <= 0;
#100;
rst <= 1;
#1000000;
end


endmodule