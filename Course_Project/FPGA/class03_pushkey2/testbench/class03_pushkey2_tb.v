`timescale 1ns/1ns
module class03_pushkey2_tb();

wire out;
reg in,clk,rst;

class03_pushkey2 class03_pushkey2_01(
	.in(in),
	.out(out),
	.clk(clk),
	.rst(rst)
);

initial begin
in <= 0;
clk <= 0;
rst <= 0;
end

always #1 clk <= ~clk;

initial begin
	#100;
	rst <= 1;
	#100;
	in <= 1;
	#220000;
	in <= 0;
	#4000000;
	$stop;
end

endmodule