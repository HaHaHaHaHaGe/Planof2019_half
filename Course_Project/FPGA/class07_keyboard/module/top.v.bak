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

reg rdreq;
reg wrreq;
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

reg flag2;
always@(posedge clk,negedge rst)
if(!rst) begin
	wrreq <= 0;
	flag2 <= 0;
end
else case(flag2)
	0: if(irq) begin flag2 <= 1; wrreq <= 1; end else flag2 <= 0;
	1:begin wrreq <= 0; if(irq == 0) flag2 <= 0; end
endcase
	
	
always@(posedge clk,negedge rst)
if(!rst) begin
	start <= 1'b0;
	clr <= 0;
	flag <= 4'b0;
	rdreq <= 0;
end
else 
case(flag)
		0: if(empty == 0) begin rdreq <= 1; flag <= 1; end else flag <= 0;
		1: begin rdreq <= 0; flag <= 2; start <= 1; end
		2: begin start <= 0; flag <= 3; end 
		3: if(busy == 0) flag <= 0;
endcase
	


endmodule