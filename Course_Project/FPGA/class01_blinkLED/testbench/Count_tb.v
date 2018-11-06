`timescale 1ns/1ns
`define clk_period 10

module Count_tb;
	
	reg clk,clr;
	wire out;

	Count count(
		.clk(clk),
		.clr(clr),
		.out(out)
	);
	
	initial begin
	clk = 1'b0;
	clr = 1'b0;
	end
	
	always #(`clk_period/2) clk = ~clk;
	
	initial begin
	
	#(`clk_period * 10)
	clr = 1'b1;
	#(`clk_period * 10)
	clr = 1'b0;
	#(`clk_period * 1000000)
	clr = 1'b1;
	$stop;
	end
	
endmodule