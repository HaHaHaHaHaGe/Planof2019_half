`timescale 1ns/1ns
module count_led_tb;


wire led1,led2,led3,led4;
reg clk,rst;

count_led count_led_01(
	.led1(led1),
	.led2(led2),
	.led3(led3),
	.led4(led4),
	.clk(clk),
	.rst(rst)
);

initial begin
clk = 0;
rst = 0;
end

always #1 clk=!clk;

initial begin
#10;
rst = 1;
#1000;
$stop;
end



endmodule