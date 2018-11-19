`timescale 1ns/1ns
module uart_rx_tb();

reg clk,rst,rx;
wire irq;
wire [7:0]data;
uart_rx uart_rx1(
	.clk(clk),
	.rst(rst),
	.irq(irq),
	.data(data),
	.rx(rx)
);

initial begin
clk <= 0;
rst <= 1;
rx <= 1;
end

always #10 clk <= ~clk;

initial begin
#100;
rst <= 0;
#100;
rst <= 1;
#100000;

#8680;
rx <= 0;
#8680;
rx <= 0;
#8680;
rx <= 0;
#8680;
rx <= 0;
#8680;
rx <= 0;
#8680;
rx <= 0;
#8680;
rx <= 0;
#8680;
rx <= 0;
#8680;
rx <= 1;
#8680;
rx <= 1;
@(posedge irq);
#100000;

$stop;
end

endmodule