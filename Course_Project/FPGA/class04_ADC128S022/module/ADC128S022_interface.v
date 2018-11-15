module ADC128S022_interface(
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

input [2:0]ADDR;
input START,RST,CLK;

output reg BUSY;
output reg [11:0]DATA;

output reg adc_sclk,adc_saddr,adc_csn;
input adc_sdat;

reg flag;
reg [2:0]Address;
reg [7:0]cnt;
reg [11:0]readdata;
reg [3:0]cnt2;

localparam WAIT_STATE = 1'b0;
localparam BUSY_STATE = 1'b1;

always@(posedge CLK,negedge RST)
if(!RST) begin
	DATA <= 12'b0;
	BUSY <= 1'b0;
	adc_csn <= 1'b1;
	adc_saddr <= 1'b0;
	adc_sclk <= 1'b1;
	Address <= 3'b0;
	flag <= WAIT_STATE;
	cnt <= 6'b0;
	readdata <= 12'b0;
	cnt2 <= 4'b0;
end
else case(flag)
	WAIT_STATE:
		if(START) begin
			Address <= ADDR;
			flag <= BUSY_STATE;
			BUSY <= 1'b1;
			cnt <= 6'b0;
			adc_csn <= 1'b0;
			cnt2 <= 4'd11;
		end
		else begin
			adc_csn <= 1'b1;
			BUSY <= 1'b0;
		end
	BUSY_STATE: begin
		adc_sclk <= ~adc_sclk;
		cnt <= cnt + 6'b1;
		case(cnt)
			6'd3,6'd5,6'd7:	begin adc_saddr <= Address[2]; Address <= Address << 1; end
			6'd9,6'd11,6'd13,6'd15,6'd17,6'd19,6'd21,6'd23,6'd25,6'd27,6'd29,6'd31:
									begin readdata[cnt2] <= adc_sdat; cnt2 <= cnt2 - 1'b1;  end
			6'd32:begin flag <= WAIT_STATE; DATA <= readdata; end
		endcase
		end
	default:
		flag <= WAIT_STATE;
endcase


endmodule