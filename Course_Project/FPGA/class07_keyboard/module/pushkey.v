module pushkey(
	clk,
	key,
	out
);

input clk,key;
output reg out;

reg flag;
reg [20:0]cnt;

localparam PUSH = 1'b1;
localparam NO_PUSH = 1'b0;

always@(posedge clk) begin

if(!key) 
	flag <= PUSH;
else begin
	cnt[20:0] <= 21'd0;
	flag <= NO_PUSH;
end

case(flag)
	NO_PUSH:
		out <= 1'b0;
	PUSH:	if(cnt[20:0] == 21'd999999)
			out <= 1'b1;
		else
			cnt <= cnt + 21'b1;
endcase
end
endmodule