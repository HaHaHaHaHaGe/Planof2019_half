module tlv5618a_interface(
	data,
	clk,
	rst,
	start,
	busy,
	dac_sclk,
	dac_din,
	dac_csn
);

input [15:0]data;
input clk,rst,start;
output reg busy,dac_sclk,dac_din,dac_csn;

localparam WAIT_STATE = 1'b1;
localparam BUSY_STATE = 1'b0;

reg flag;
reg [15:0]DATA;
reg [7:0]cnt;
always@(posedge clk,negedge rst)
if(!rst) begin
	busy <= 1'b0;
	dac_sclk <= 1'b1;
	dac_din <= 1'b0;
	dac_csn <= 1'b1;
	flag <= WAIT_STATE;
	DATA <= 16'b0;
	cnt <= 8'd15;
end
else case(flag)
WAIT_STATE: 
	if(start) begin
		flag <= BUSY_STATE;
		DATA <= data;
		dac_csn <= 1'b0;
		cnt <= 8'd15;
		busy <= 1'b1;
		dac_din <= data[15];
	end
	else begin
		dac_csn <= 1'b1;
		busy <= 1'b0;
	end
BUSY_STATE: 
	if(cnt == 8'hff)  begin
		flag <= WAIT_STATE;
		dac_sclk <= 1'b1;
	end
	else begin
		dac_sclk <= ~dac_sclk;
		if(dac_sclk)
			cnt <= cnt - 1'b1;
		else
			dac_din <= DATA[cnt];
			
	end
default:
	flag <= WAIT_STATE;
endcase
endmodule