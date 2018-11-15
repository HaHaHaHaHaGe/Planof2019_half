`timescale 1ns/1ns
module tlv5618a_device_tb();

reg [11:0]DATA_A;
reg [11:0]DATA_B;
reg clk,rst;


wire dac_sclk ,dac_din ,dac_csn;

tlv5618a_device tlv5618a_device_1(
	.DATA_A(DATA_A),
	.DATA_B(DATA_B),
	.clk(clk),
	.rst(rst),
	.dac_sclk(dac_sclk),
	.dac_din(dac_din),
	.dac_csn(dac_csn)
);


initial begin
DATA_A <= 12'b101010101111;
DATA_B <= 12'b111110101010;
clk <= 0;
rst <= 1;
end

always #10 clk <= ~clk;

initial begin
#100;
rst <= 0;
#100;
rst <= 1;

end


endmodule