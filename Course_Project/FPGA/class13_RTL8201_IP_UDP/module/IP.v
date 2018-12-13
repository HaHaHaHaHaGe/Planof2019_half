module IP(
	src_mac,
	dst_mac,
	src_ip,
	dst_ip,
	data,
	data_type,
	len,
	start,
	busy,
	clk,
	rst,
	
	SEND_DATA,
	SENT_BUSY,
	SEND_EN,
);


input [47:0]src_mac;
input [47:0]dst_mac;
input [31:0]src_ip;
input [31:0]dst_ip;
input [15:0]len;
input [7:0]data;
input [7:0]data_type;
input clk,rst,SENT_BUSY,start;

reg [15:0]dlen;
reg [47:0]mac;
reg [47:0]mac_2;
reg [31:0]sip;
reg [31:0]dip;

output reg [7:0]SEND_DATA;
output reg SEND_EN,busy;

reg [6:0]Send_State;


wire [31:0]sum;
wire [15:0]checksum_result;

assign sum = {4'd4,4'd5,8'd0} + dlen + 16'd0 
						+ 16'd0 + {8'h40,data_type} + src_ip[31:16]
						+ src_ip[15:0] + dst_ip[31:16] + dst_ip[15:0];
	
assign checksum_result = ~(sum[31:16] + sum[15:0]);

reg rdreq,wrreq;
wire empty;
wire [7:0]q;
wire[10:0]usedw;
reg aclr;
IP_FIFO IP_FIFO1 (
	.clock(clk),
	.data(data),
	.rdreq(rdreq),
	.wrreq(wrreq),
	.empty(empty),
	.q(q),
	.usedw(usedw),
	.aclr(aclr)
);



always@(negedge clk)
if(start)
	wrreq <= 1;
else
	wrreq <= 0;









always@(negedge clk,negedge rst)
if(!rst) begin
	SEND_DATA <= 8'b0;
	SEND_EN <= 1'b0;
	Send_State <= 0;
	busy <= 0;
	dlen <= 0;
	rdreq <= 0;
	aclr <= 0;
end
else case (Send_State)
	0:
		if(start) begin
			Send_State <= 1;
			busy <= 1;
			mac <= src_mac;
			mac_2 <= dst_mac;
			sip <= src_ip;
			dip <= dst_ip;
			SEND_EN <= 1;
			dlen <= len + 16'd20;
		end
		else
			busy <= 0;
	1:begin Send_State <= 2; SEND_DATA <= mac_2[47:40]; end
	2:begin Send_State <= 3; SEND_DATA <= mac_2[39:32]; end
	3:begin Send_State <= 4; SEND_DATA <= mac_2[31:24]; end
	4:begin Send_State <= 5; SEND_DATA <= mac_2[23:16]; end
	5:begin Send_State <= 6; SEND_DATA <= mac_2[15:8]; end
	6:begin Send_State <= 7; SEND_DATA <= mac_2[7:0]; end
	7:begin Send_State <= 8; SEND_DATA <= mac[47:40]; end
	8:begin Send_State <= 9; SEND_DATA <= mac[39:32]; end	
	9:begin Send_State <= 10; SEND_DATA <= mac[31:24]; end	
	10:begin Send_State <= 11; SEND_DATA <= mac[23:16]; end
	11:begin Send_State <= 12; SEND_DATA <= mac[15:8]; end
	12:begin Send_State <= 13; SEND_DATA <= mac[7:0]; end
	13:begin Send_State <= 14; SEND_DATA <= 8'h08; end
	14:begin Send_State <= 15; SEND_DATA <= 8'h00; end
	15:begin Send_State <= 16; SEND_DATA <= 8'h45; end
	16:begin Send_State <= 17; SEND_DATA <= 8'h00; end
	
	17:begin Send_State <= 18; SEND_DATA <= dlen[15:8]; end
	18:begin Send_State <= 19; SEND_DATA <= dlen[7:0]; end
	
	19:begin Send_State <= 20; SEND_DATA <= 8'h00; end
	20:begin Send_State <= 21; SEND_DATA <= 8'h00; end
	
	21:begin Send_State <= 22; SEND_DATA <= 8'h00; end
	22:begin Send_State <= 23; SEND_DATA <= 8'h00; end
	
	23:begin Send_State <= 24; SEND_DATA <= 8'h40; end
	24:begin Send_State <= 25; SEND_DATA <= data_type; end
	///////////////
	25:begin Send_State <= 26; SEND_DATA <= checksum_result[15:8]; end	
	26:begin Send_State <= 27; SEND_DATA <= checksum_result[7:0]; end
	////////////////
	27:begin Send_State <= 28; SEND_DATA <= src_ip[31:24]; end	
	28:begin Send_State <= 29; SEND_DATA <= src_ip[23:16]; end
	29:begin Send_State <= 30; SEND_DATA <= src_ip[15:8]; end
	30:begin Send_State <= 31; SEND_DATA <= src_ip[7:0]; end
	31:begin Send_State <= 32; SEND_DATA <= dst_ip[31:24]; end
	32:begin Send_State <= 33; SEND_DATA <= dst_ip[23:16]; end	
	33:begin Send_State <= 34; SEND_DATA <= dst_ip[15:8]; end	
	34:begin Send_State <= 35; SEND_DATA <= dst_ip[7:0]; rdreq <= 1; end
	
	
	35:
		if(empty) begin
			SEND_EN <= 0;
			Send_State <= 36;
			aclr <= 1;
			rdreq <= 0;
		end
		else
			SEND_DATA <= q;

	
	36:begin Send_State <= 37; SEND_EN <= 0; aclr <= 0;end
	37: Send_State <= 38;
	38: if(SENT_BUSY == 0) Send_State <= 0; else Send_State <= 38;
endcase


endmodule