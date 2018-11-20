`timescale 1ns/1ns
module top_tb();

reg clk,rst,rx;
wire tx;

reg [7:0]char;

top top1(
	.clk(clk),
	.rst(rst),
	.tx(tx),
	.rx(rx)
);


initial begin
	clk <= 0;
	rst <= 1;
	rx <= 1;
	char <= "A";
end

always #10 clk<=~clk;







initial begin
#100;
rst <= 0;
#100;
rst <= 1;
#1000;

repeat (260) begin
#8680;
rx <= 0;
#8680;
rx <= char[0];
#8680;
rx <= char[1];
#8680;
rx <= char[2];
#8680;
rx <= char[3];
#8680;
rx <= char[4];
#8680;
rx <= char[5];
#8680;
rx <= char[6];
#8680;
rx <= char[7];
#8680;
rx <= 1;

char <= char + 1;
if(char == "Z")
	char <= "A";
end
	
	

#8680;
#8680;
#8680;
#8680;
#8680;
#8680;
#8680;#8680;#8680;
$stop;
end

endmodule