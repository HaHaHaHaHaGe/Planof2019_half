`timescale 1ns/1ns
module tlv5618a_interface_tb();

reg [15:0]data;
reg clk,rst,start;
wire busy,dac_sclk,dac_din,dac_csn;


tlv5618a_interface tlv5618a_interface1(
	.data(data),
	.clk(clk),
	.rst(rst),
	.start(start),
	.busy(busy),
	.dac_sclk(dac_sclk),
	.dac_din(dac_din),
	.dac_csn(dac_csn)
);

initial begin
data <= 16'b1100110011001100;
clk <= 0;
rst <= 1;
start <= 0;
end


always #10 clk <= ~clk;

initial begin
#100;
rst <= 0;
#100;
rst <= 1;
#100;
start <= 1;
#100;
start <= 0;
@(negedge busy);
#100;

data <= 16'b1110110011000111;

#100;
start <= 1;
#100;
start <= 0;
@(negedge busy);
$stop;
end

endmodule