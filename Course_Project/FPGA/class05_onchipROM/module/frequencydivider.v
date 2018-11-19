module frequencydivider(
	clk,
	rst,
	fclk
);

input clk,rst;
output reg fclk;

reg [31:0]cnt;

always@(posedge clk,negedge rst)
if(!rst) begin
	cnt <= 0;
	fclk <= 0;
end
else if(cnt == 500) begin
	cnt <= 0;
	fclk <= ~fclk;
end
else
	cnt <= cnt + 1;
	
endmodule