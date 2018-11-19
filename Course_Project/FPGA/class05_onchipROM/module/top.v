module top(
	rst,
	clk,
	lock595,
	out595,
	clk595
);

input rst,clk;
output lock595,out595,clk595;

wire clk1;
wire clk2;
wire clk3;
wire [31:0]data;
reg [2:0]addr;

frequencydivider frequencydivider1(
	.clk(clk),
	.rst(rst),
	.fclk(clk1)
);


frequencydivider frequencydivider2(
	.clk(clk1),
	.rst(rst),
	.fclk(clk2)
);

frequencydivider frequencydivider3(
	.clk(clk2),
	.rst(rst),
	.fclk(clk3)
);


rom rom1 (
	.address(addr),
	.clock(clk3),
	.q(data)
);



BCDDisplay BCDDisplay1(
	.clk(clk),
	.rst(rst),
	.data(data),
	.lock595(lock595),
	.out595(out595),
	.clk595(clk595)
);


always@(negedge clk3,negedge rst)
if(!rst)
	addr <= 3'b0;
else
	addr <= addr + 3'b1;

endmodule