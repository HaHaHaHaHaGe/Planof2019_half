module count_led(
	led1,
	led2,
	led3,
	led4,
	clk,
	rst
);

reg [3:0]cnt;
output wire led1,led2,led3,led4;
input clk,rst;

always@(posedge clk or negedge rst)
if(!rst)
	cnt = 4'b0;
else begin
	cnt = cnt + 1'b1;
end

assign led1 = cnt[0];
assign led2 = cnt[1];
assign led3 = cnt[2];
assign led4 = cnt[3];

endmodule