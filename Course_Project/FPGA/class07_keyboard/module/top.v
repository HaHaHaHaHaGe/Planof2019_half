module top(
	clk,
	rst,
	tx,
	rx,
	line_in,
	line_out
);

input clk,rst,rx;
input [3:0]line_in;
output[3:0]line_out;
output tx;
reg start;
wire busy;

reg [7:0]data;

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
	.data(),
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

wire [15:0]keyout;
reg [15:0]keyout2;

keyboard keyboard1(
	.clk(clk),
	.rst(rst),
	.keyout(keyout),
	.line_in(line_in),
	.line_out(line_out),
);


reg [3:0]flag;
reg irq2;

reg [2:0]flag2;
always@(posedge clk,negedge rst)
if(!rst) begin
	wrreq <= 0;
	flag2 <= 0;
	keyout2 <= 16'b0;
	data <= 0;
end
else case(flag2)
	0: if(keyout2 != keyout) begin flag2<=1; data <= keyout[15:8]; end
	1:	begin wrreq <= 1; flag2<=2;  end
	2: begin wrreq <= 0; flag2 <= 3; data <= keyout[7:0]; end
	3: begin wrreq <= 1; flag2<=4; end
	4: begin wrreq <= 0; keyout2<=keyout; flag2<=0;end
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