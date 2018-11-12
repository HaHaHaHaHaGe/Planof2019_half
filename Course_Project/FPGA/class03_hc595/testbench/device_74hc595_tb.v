`timescale 1ns/1ns
module device_74hc595_tb();

reg clk,rst,lock;
reg [15:0]data;
wire busy,lock595,out595,clk595;


device_74hc595 device_74hc595_01(
	.clk(clk),
	.rst(rst),
	.data(data),
	.busy(busy),
	.lock(lock),
	.lock595(lock595),
	.out595(out595),
	.clk595(clk595)
);

initial begin
	clk <= 0;
	rst <= 1;
	data <= 0;
	lock <= 0;
	
end

always #1000 clk <= ~clk;




task RESET; 
begin
#5000;
rst <= 0;
#5000;
rst <= 1;
#5000;
end
endtask



task SendDATA; 
begin
#5000;
data <= 16'b1110101010101011;
#5000;
lock <= 1;
#5000;
lock <= 0;
#5000;
end
endtask


initial begin
#5000;
RESET;
SendDATA;
@(negedge busy);
SendDATA;
@(negedge busy);
SendDATA;
@(negedge busy);
SendDATA;
@(negedge busy);
SendDATA;
@(negedge busy);
$stop;

end


endmodule