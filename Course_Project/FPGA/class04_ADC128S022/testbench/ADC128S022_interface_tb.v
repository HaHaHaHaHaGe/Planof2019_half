`timescale 1ns/1ns
module ADC128S022_interface_tb();

reg [2:0]ADDR;
reg START,CLK,RST,adc_sdat;

wire [11:0]DATA;
wire adc_sclk,adc_saddr,adc_csn,BUSY;


ADC128S022_interface ADC128S022_interface_1(
	ADDR,
	DATA,
	START,
	BUSY,
	CLK,
	RST,
	adc_sclk,
	adc_saddr,
	adc_csn,
	adc_sdat
);

initial begin
ADDR <= 3'b101;
START <= 0;
RST <= 1;
CLK <= 0;
adc_sdat <= 0;
end

always #10 begin CLK <= ~ CLK; adc_sdat <= ~adc_sdat; end

initial begin
#100;
RST <= 0;
#100;
RST <= 1;
#100;
START <= 1;
#100;
START <= 0;
#100;
@(negedge BUSY);
$stop;
end

endmodule