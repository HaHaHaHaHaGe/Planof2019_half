module test_74hc595(
	clk,
	rst,
	key,
	lock595,
	out595,
	clk595
);
wire lock;
input clk;
input wire rst,key;
wire rst2;
reg [31:0]data;

output lock595,out595,clk595;

wire rst3;
wire clk2;

inkey inkey_1(
	.in(key),
	.out(lock),
	.clk(clk)
);

inkey inkey_2(
	.in(rst),
	.out(rst2),
	.clk(clk)
);


BCDDisplay BCDDisplay_1(
	.clk(clk),
	.rst(rst3),
	.data(data),
	.lock595(lock595),
	.out595(out595),
	.clk595(clk595)
);

frequencydivider frequencydivider2(
	.clk(clk),
	.rst(rst3),
	.fclk(clk2)
);


always @(negedge rst3,posedge clk2)
begin
if(!rst3)
	data <= 0;
else
	data <= data + 1;
end

assign rst3 = ~rst2;

endmodule