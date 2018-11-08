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
	
	localparam CHECK_W = 3'd0;
	localparam CHECK_E = 3'd1;
	localparam CHECK_L = 3'd2;
	localparam CHECK_C = 3'd3;
	localparam CHECK_O = 3'd4;
	localparam CHECK_M = 3'd5;

	
	always@(posedge clk or negedge rst_n)
	if(!rst_n) begin
		state <= 3'd0;
		cnt <= 4'b0;
	end
	else begin
		case(state)
			CHECK_W:
				if(dv)begin
					if(data == "W")
						state <= CHECK_E;
					else
						state <= CHECK_W;
				end
				else
					state <= CHECK_W;
			CHECK_E:
				if(dv)begin
					if(data == "e")
						state <= CHECK_L;
					else if(data == "W")
						state <= CHECK_E;
					else
						state <= CHECK_W;
				end
				else
					state <= CHECK_W;
			CHECK_L:
				if(dv)begin
					if(data == "l")
						state <= CHECK_C;
					else if(data == "W")
						state <= CHECK_E;
					else
						state <= CHECK_W;
				end
				else
					state <= CHECK_W;
			CHECK_C:
				if(dv)begin
					if(data == "c")
						state <= CHECK_O;
					else if(data == "W")
						state <= CHECK_E;
					else
						state <= CHECK_W;
				end
				else
					state <= CHECK_W;
			CHECK_O:
				if(dv)begin
					if(data == "o")
						state <= CHECK_M;
					else if(data == "W")
						state <= CHECK_E;
					else
						state <= CHECK_W;
				end
				else
					state <= CHECK_W;
			CHECK_M:
				if(dv)begin
					if(data == "m") begin
						state <= CHECK_W;
						cnt <= cnt + 1'b1;
					end
					else if(data == "W")
						state <= CHECK_E;
					else
						state <= CHECK_W;
				end
				else
					state <= CHECK_W;
			default:state <= CHECK_W;
		endcase
	end
	assign num = cnt;

endmodule