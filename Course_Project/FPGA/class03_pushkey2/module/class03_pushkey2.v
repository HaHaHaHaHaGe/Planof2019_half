module class03_pushkey2(
	in,
	out,
	clk,
	rst
);

	input in,clk,rst;
	output reg out;

	reg [5:0]ledblink;
	reg [31:0]ledcnt;
	reg [31:0]cnt;
	
	
	reg [3:0]flag;
	localparam One_Sec = 4'b0000;
	localparam One_Two_Sec = 4'b0001;
	localparam Two_Sec = 4'b0011;
	localparam NoPUSH = 4'b0010;
	
	always@(posedge clk,negedge rst) begin
		if(!rst) begin
			flag <= NoPUSH;
			cnt <= 0;
			ledcnt <= 0;
			ledblink <= 0;
			out <= 0;
		end
		else if(in == 1) begin
			ledblink <= 0;
			ledcnt <= 0;
			cnt <= cnt + 1;
			if(cnt > 100_000_000)
				flag <= Two_Sec;
			else if (cnt > 50_000_000)
				flag <= One_Two_Sec;
			else
				flag <= One_Sec;
		end
		else begin
			cnt <= 0;
			case(flag)
				One_Sec:
					if(ledblink == 10) 
						flag <= NoPUSH;
					else if(ledcnt > 25_000_000) begin
						ledcnt <= 0;
						out <= ~out;
						ledblink <= ledblink + 1;
					end
					else
						ledcnt <= ledcnt + 1;
				One_Two_Sec:
					if(ledblink == 20) 
						flag <= NoPUSH;
					else if(ledcnt > 25_000_000) begin
						ledcnt <= 0;
						out <= ~out;
						ledblink <= ledblink + 1;
					end
					else
						ledcnt <= ledcnt + 1;
				Two_Sec:
					if(ledblink == 40) 
						flag <= NoPUSH;
					else if(ledcnt > 25_000_000) begin
						ledcnt <= 0;
						out <= ~out;
						ledblink <= ledblink + 1;
					end
					else
						ledcnt <= ledcnt + 1;
				NoPUSH: begin
						ledblink <= 0;
						ledcnt <= 0;
						out <= 0;
					end
				default: 
					flag <= NoPUSH;

			endcase
			//flag <= One_Sec;
		end
	end
	
endmodule