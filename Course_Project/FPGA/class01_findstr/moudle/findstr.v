module findstr(
	clk,
	rst_n,
	dv,
	data,
	num,
	get_flag
);
	input clk;
	input rst_n;
	input dv;
	input [7:0]data;
	
	output [3:0]num;
	output get_flag;
	
	reg [3:0]cnt;
	reg [2:0]state;
	
	always@(posedge clk or negedge rst_n)
	if(!rst_n) begin
		state <= 3'd0;
		cnt <= 4'b0;
	end
	else begin
		case(state)
			0:
				if(dv)begin
					if(data == "W")
						state <= 3'd1;
					else
						state <= 3'd0;
				end
			1:
				if(dv)begin
					if(data == "e")
						state <= 3'd2;
					else if(data == "W")
						state <= 3'd1;
					else
						state <= 3'd0;
				end
			2:
				if(dv)begin
					if(data == "l")
						state <= 3'd3;
					else if(data == "W")
						state <= 3'd1;
					else
						state <= 3'd0;
				end
			3:
				if(dv)begin
					if(data == "c")
						state <= 3'd4;
					else if(data == "W")
						state <= 3'd1;
					else
						state <= 3'd0;
				end
			4:
				if(dv)begin
					if(data == "o")
						state <= 3'd5;
					else if(data == "W")
						state <= 3'd1;
					else
						state <= 3'd0;
				end
			5:
				if(dv)begin
					if(data == "m") begin
						state <= 3'd0;
						cnt <= cnt + 1'b1;
					end
					else if(data == "W")
						state <= 3'd1;
					else
						state <= 3'd0;
				end
			default:state <= 3'd0;
		endcase
	end
	assign num = cnt;

endmodule