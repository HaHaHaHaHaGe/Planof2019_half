module uart_rx(
	clk,
	rst,
	irq,
	data,
	rx
);

input clk,rst,rx;
output reg irq;
output reg [7:0]data;

reg [8:0]cnt;
reg [3:0]cnt2;
reg [7:0]outdata;

reg flag;
reg last;

reg begin_bit;
reg rx_1,rx_2;

localparam CHECK_STATE = 1'b0;
localparam COUNT_STATE = 1'b1;




always@(posedge clk,negedge rst)
if(!rst) begin
	rx_1 <= 1'b1;
	rx_2 <= 1'b1;
end
else begin
	rx_1 <= rx;
	rx_2 <= rx_1;
end



always@(posedge clk,negedge rst) begin
if(!rst) begin
	cnt <= 9'b0;
	irq <= 1'b0;
	data <= 8'b0;
	outdata <=7'b0;
	flag <= COUNT_STATE;
	last <= rx_2;
	cnt2 <= 4'b0;
	begin_bit <= 1'b0;
end
else
case(flag)

COUNT_STATE:
	if((begin_bit && cnt == 9'd433) || (!begin_bit && last == 1'b1 && rx_2 == 1'b0)) begin
		flag <= CHECK_STATE;
		cnt <= 9'b0;
	end
	else begin
		last <= rx_2;
		irq <= 1'b0;
		cnt <= cnt + 1'b1;	
	end

CHECK_STATE: begin
	if(!begin_bit) begin
		begin_bit <= 1'b1;
		cnt2 <= 1'b1;
		cnt <= 9'd216;
	end
	else if(cnt2 == 4'd10) begin
		begin_bit <= 1'b0;
		irq <= 1'b1;
		data <= outdata;
		cnt2 <= 4'b0;
	end
	else begin
		outdata <= {rx_2,outdata[7:1]};
		cnt2 <= cnt2 + 1'b1;
	end
	flag <= COUNT_STATE;

end		
endcase
	

	

end
endmodule