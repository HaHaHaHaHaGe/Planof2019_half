module inkey_tb();

reg in,clk;
wire out;

inkey inkey_1(
	.in(in),
	.out(out),
	.clk(clk)
);

reg [31:0]delay;

initial begin
in = 1;
clk = 0;
end

always #1 clk <= ~clk;

initial begin
	#100;

	repeat(50) begin
		delay = {$random} % 65536;
		#delay in <= ~in;
	end
	
	in <=0;
	#10000000;
	in <=1;
	
	repeat(50) begin
		delay = {$random} % 65536;
		#delay in <= ~in;
	end
	
	#20000000;
	
	$stop;
end	

endmodule