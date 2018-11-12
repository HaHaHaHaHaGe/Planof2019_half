module main(
	in,
	clk,
	out,
	rst,
	keyout
);


input in;
input clk;
input rst;
output out;
output wire keyout;
wire push;

inkey inkey_1(
	.in(in),
	.out(keyout),
	.clk(clk)
);



class03_pushkey2 class03_pushkey2_1(
	.in(keyout),
	.out(out),
	.clk(clk),
	.rst(rst)
);


endmodule