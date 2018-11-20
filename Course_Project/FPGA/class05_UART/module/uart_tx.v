module uart_tx(
	clk,
	rst,
	start,
	data,
	busy,
	tx
);

input clk,rst,start;
input [7:0]data;
output reg busy,tx;

reg [7:0]Data;
reg flag;
reg [3:0]flag2;

reg [8:0]cnt;


localparam WAIT_STATE = 1'b0;
localparam SEND_STATE = 1'b1;

always@(posedge clk,negedge rst)
if(!rst) begin
	flag <= WAIT_STATE;
	cnt <= 8'b0;
	tx <= 1'b1;
	busy <= 1'b0;
	flag2 <= 4'b0;
	Data <= 8'b0;
end
else case(flag)
WAIT_STATE:
	if(start)begin
		flag <= SEND_STATE;
		cnt <= 8'b0;
		busy <= 1'b1;
		flag2 <= 4'b0;
		Data <= data;
		tx <= 1'b0;
	end
	else
		busy <= 1'b0;
SEND_STATE: 
	if(cnt == 9'd434) begin
		cnt<=9'b0;
		flag2 <= flag2 + 1'b1;
		case(flag2)
		8:tx <= 1'b1;
		9:begin  flag <= WAIT_STATE; busy <= 1'b0; end
		default:
			tx <= Data[flag2];
		endcase
	end
	else
		cnt <= cnt + 1'b1;
		
endcase
endmodule