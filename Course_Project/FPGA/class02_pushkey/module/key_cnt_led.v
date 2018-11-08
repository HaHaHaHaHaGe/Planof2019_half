module key_cnt_led(
	led1,
	led2,
	led3,
	led4,
	key,
	clk,
	rst
);

input wire clk,rst;
input key;
reg key_1;
reg key_2;
output wire led1,led2,led3,led4;
wire outkey;

pushkey pushkey_01(
	.clk(clk),
	.key(key_2),
	.out(outkey)
);

count_led count_led_01(
	.led1(led1),
	.led2(led2),
	.led3(led3),
	.led4(led4),
	.clk(outkey),
	.rst(rst)
);

always@(posedge clk) begin
key_1 <= key;
key_2 <= key_1;
end
endmodule