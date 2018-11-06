module Count(
	clk,
	clr,
	out
);
	input clk;
	input clr;
	
	output reg out;
	
	reg [31:0]cnt;
	
	always@(posedge clk,posedge clr)
	if(clr) begin
		cnt <= 32'b0;
		out <= 1'b0;
	end
	else if(cnt == 32'd50_000_000 / 1000) begin
		out <= ~out;
		cnt <= 32'b0;
	end
	else cnt <= cnt + 32'b1;

		
endmodule