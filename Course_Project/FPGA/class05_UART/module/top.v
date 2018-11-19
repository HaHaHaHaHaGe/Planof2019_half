module top(
	clk,
	rst,
	tx,
	rx,
);

input clk,rst,rx;
output tx;

reg start;
wire busy;

wire [7:0]data;
reg [7:0]data2;

uart_tx uart_tx1(
	.clk(clk),
	.rst(rst),
	.start(start),
	.data(data2),
	.busy(busy),
	.tx(tx)
);


wire irq;
reg clr;
uart_rx uart_rx1(
	.clk(clk),
	.rst(rst),
	.irq(irq),
	.data(data),
	.rx(rx)
);

reg flag;



always@(posedge clk,negedge rst)
if(!rst) begin
	start <= 1'b0;
	clr <= 0;
	flag <= 0;
end
else 
case(flag)
0:
if(irq) begin
	flag <= 1;
	data2 <= data;
end	
else begin
	start <= 0;
end	
	
	
1: begin
start <= 1;
flag <= 0;

end
endcase

endmodule