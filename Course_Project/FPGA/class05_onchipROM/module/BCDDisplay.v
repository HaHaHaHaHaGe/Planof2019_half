module BCDDisplay(
	clk,
	rst,
	data,
	lock595,
	out595,
	clk595
);
wire fclk;
input clk,rst;
input [31:0]data;
output lock595,out595,clk595;
reg flag;
reg [7:0]selecter;
reg [7:0]srcdata;
wire [7:0]dstdata;
reg [31:0]data_buffer;
reg lock;
wire busy;
reg doonce;
reg [7:0]cnt;

localparam Wait_Busy = 1'b0;
localparam Circle_Play = 1'b1;

BCDdecoder BCDdecoder_01(
	.data(srcdata),
	.out(dstdata)
);

frequencydivider frequencydivider_01(
	.clk(clk),
	.rst(rst),
	.fclk(fclk)
);

device_74hc595 device_74hc595_01(
	.clk(fclk),
	.rst(rst),
	.data({dstdata,selecter}),
	.busy(busy),
	.lock(lock),
	.lock595(lock595),
	.out595(out595),
	.clk595(clk595)
);
always@(posedge clk,negedge rst)
if(!rst) begin
	selecter <= 8'b0000_0001;
	data_buffer <= 32'b0;
	flag <= Circle_Play;
	srcdata <= 8'b0;
	lock <= 0;
	cnt <= 8'd4;
	doonce <= 0;
end
else begin
	data_buffer <= data;
	case(flag)
		Circle_Play: begin
			srcdata <= data_buffer >> cnt;
			selecter <= {selecter[6:0],selecter[7]};
			flag <= Wait_Busy;
			doonce <= 0;
			
			if(cnt == 8'd28)
				cnt <= 8'b0;
			else
				cnt <= cnt + 4;
		end
		Wait_Busy:
			if(busy) begin
				lock <= 0;
				doonce <= 1;
			end
			else if(doonce)
				flag <= Circle_Play;
			else
				lock <= 1;
	endcase
end
endmodule