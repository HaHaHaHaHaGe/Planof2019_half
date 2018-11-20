module top(
	clk,
	rst,
	tx,
	rx,
	led
);

input clk,rst,rx;
output tx,led;

reg led;
reg start;
wire busy;

wire [7:0]data;

reg rdreq;
wire wrreq;
wire empty,full;
wire [7:0]qout;
uart_tx uart_tx1(
	.clk(clk),
	.rst(rst),
	.start(start),
	.data(qout),
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



fifo fifo1 (
	.clock(clk),
	.data(data),
	.rdreq(rdreq),
	.wrreq(wrreq),
	.empty(empty),
	.full(full),
	.q(qout)
);


reg [3:0]flag;
reg irq2;


always@(posedge clk,negedge rst)begin
	if(!rst) 
		led <=0;
	else begin
	irq2 <= irq;
	if(irq2 == 1 && data != 8'd48)
		led <=1;
	end
end	
	
always@(posedge clk,negedge rst)
if(!rst) begin
	start <= 1'b0;
	clr <= 0;
	flag <= 4'b0;
	rdreq <= 0;
end
else 
case(flag)
0:
if(!empty) begin
	flag <= 1;
	rdreq <= 1;
end	
else begin
	rdreq <= 0;
	start <= 0;
end	
	
	
1: 
if(!busy) begin
	start <= 1;
	flag <= 2;
	rdreq <= 0;
end
2: begin
start <= 0;
flag <= 0;
end

endcase
assign wrreq = irq2;
endmodule