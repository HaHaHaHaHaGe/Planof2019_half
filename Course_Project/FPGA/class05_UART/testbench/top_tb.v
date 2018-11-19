`timescale 1ns/1ns
module top_tb();

reg clk,rst,rx;
wire tx;

top top1(
	.clk(clk),
	.rst(rst),
	.tx(tx),
	.rx(rx)
);


initial begin
	clk <= 0;
	rst <= 1;
end

always #10 clk<=~clk;

initial begin
#100;
rst <= 0;
#100;
rst <= 1;
#100;

#8680;
rx <= 0;
#8680;
rx <= 1;
#8680;
rx <= 1;
#8680;
rx <= 0;
#8680;
rx <= 1;
#8680;
rx <= 1;
#8680;
rx <= 0;
#8680;
rx <= 1;
#8680;
rx <= 0;
#8680;
rx <= 1;

end

endmodule