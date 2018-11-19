module device_74hc595(
	clk,
	rst,
	data,
	busy,
	lock,
	lock595,
	out595,
	clk595
);

input clk,rst,lock;
input [15:0]data;
output reg lock595,clk595,busy,out595;

reg [4:0]send_cnt;
reg [15:0]data_buffer;

reg [1:0]flag;
localparam SEND_STATE = 2'b00;
localparam LOCK0_STATE = 2'b01;
localparam LOCK1_STATE = 2'b11;
localparam IDLE_STATE = 2'b10;

always@(posedge clk,negedge rst) 
if(!rst)begin
	send_cnt <= 5'b0;
	busy <= 1'b0;
	data_buffer <= 16'b0;
	flag <= IDLE_STATE;
	lock595 <= 1'b0;
	clk595 <= 1'b1;
	out595 <= 1'b0;
end
else 
	case(flag)
		SEND_STATE:
			if(clk595) begin
				if(send_cnt == 5'd16)
					flag <= LOCK0_STATE;
				else begin
					send_cnt <= send_cnt + 5'b1;
					out595 <= data_buffer[5'd15-send_cnt];
					clk595 <= 1'b0;
				end
			end
			else begin
				clk595 <= 1'b1;
			end
		LOCK0_STATE: begin
			lock595 <= 1'b1;
			flag <= LOCK1_STATE;
			end
		LOCK1_STATE: begin
			lock595 <= 1'b0;
			flag <= IDLE_STATE;
			end
		
		IDLE_STATE:
			if(lock)begin
				send_cnt <= 5'b0;
				data_buffer <= data;
				busy <= 1'b1;
				flag <= SEND_STATE;
			end
			else
				busy <= 1'b0;
		default:
			flag <= IDLE_STATE;
	endcase
endmodule