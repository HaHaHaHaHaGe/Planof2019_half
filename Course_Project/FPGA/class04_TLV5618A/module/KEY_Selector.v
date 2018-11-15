module KEY_Selector(
	key1,
	key2,
	clk,
	rst,
	out
);

input key1,key2,clk,rst;
output reg [2:0]out;
wire ok1,ok2;

inkey inkey1(
	.in(key1),
	.out(ok1),
	.clk(clk)
);

inkey inkey2(
	.in(key2),
	.out(ok2),
	.clk(clk)
);

reg doonce1,doonce2;
	

always@(negedge rst,posedge clk)
if(!rst) begin
	out <= 3'b0;
	doonce1 <= 1'b0;
	doonce2 <= 1'b0;
end
else begin
	if(ok1)
		doonce1 <= 1'b0;
	else 
		doonce1 <= 1'b1;
	if(ok2)
		doonce2 <= 1'b0;
	else 
		doonce2 <= 1'b1;

		
	if(ok1 && doonce1)
		out <= out + 1;
	else if(ok2 && doonce2)
		out <= out - 1;
	else 
		;
end
endmodule