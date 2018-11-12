`timescale 1ns/1ns
module BCDDisplay_tb();

reg clk,rst,lockdata;
reg [31:0]data;
wire lock595,out595,clk595;

BCDDisplay BCDDisplay_1(
	.clk(clk),
	.rst(rst),
	.lockdata(lockdata),
	.data(data),
	.lock595(lock595),
	.out595(out595),
	.clk595(clk595)
);

initial begin
	clk <= 0;
	rst <= 1;
	lockdata <= 0;
	data <= 32'h12345678;
end

always #10 clk = ~clk;

initial begin 
	#100;
	rst <= 0;
	#100;
	rst <= 1;
	#100;
	lockdata <= 1;
	#100;
	lockdata <= 0;
	#100000000;
end

endmodule