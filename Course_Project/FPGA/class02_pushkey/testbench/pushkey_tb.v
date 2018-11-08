`timescale 1ns/1ns
module pushkey_tb;

reg clk,key;
reg [15:0]ran;
wire out;

pushkey push(
	.clk(clk),
	.key(key),
	.out(out)
);


initial begin
clk = 0;
key = 1;
end


always #10 clk = ~clk;

initial begin
	#25000000;
repeat(50) begin
	ran = {$random}%65536;
	#ran key = ~key;
end
	key = 0;
	#25000000;
repeat(50) begin
	ran = {$random}%65536;
	#ran key = ~key;
end
	key = 1;
	
#25000000;
$stop;
end


endmodule