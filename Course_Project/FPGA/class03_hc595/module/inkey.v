module inkey(
	in,
	out,
	clk
);

input in,clk;
output reg out;
reg [31:0]cnt;

reg key1,key2;

localparam NoPUSH = 1'b1;
localparam PUSH = 1'b0;

always@(posedge clk) begin
key1 <= in;
key2 <= key1;

case(key2)
NoPUSH: begin
		cnt <= 0;
		out <= 0;
	end
PUSH:
	if(cnt == 1_000_000)
		out <= 1;
	else
		cnt <= cnt + 1;
endcase

end
endmodule