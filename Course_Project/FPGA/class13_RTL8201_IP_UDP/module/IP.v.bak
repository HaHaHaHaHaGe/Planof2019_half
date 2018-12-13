module ARP(
	mac_addr,
	src_ip,
	dst_ip,
	start,
	busy,
	clk,
	rst,
	
	SEND_DATA,
	SENT_BUSY,
	SEND_EN,
	CLK,
	RST
);


input [47:0]mac_addr;
input [31:0]src_ip;
input [31:0]dst_ip;
input clk,rst,SENT_BUSY,start;


reg [47:0]mac;
reg [31:0]sip;
reg [31:0]dip;

output wire CLK,RST;
output reg [7:0]SEND_DATA;
output reg SEND_EN,busy;

reg [6:0]Send_State;


always@(negedge clk,negedge rst)
if(!rst) begin
	SEND_DATA <= 8'b0;
	SEND_EN <= 1'b0;
	Send_State <= 0;
	busy <= 0;
end
else case (Send_State)
	0:
		if(start) begin
			Send_State <= 1;
			busy <= 1;
			mac <= mac_addr;
			sip <= src_ip;
			dip <= dst_ip;
			SEND_EN <= 1;
		end
		else
			busy <= 0;
	1,2,3,4,5,6:begin
		Send_State <= Send_State + 1;
		SEND_DATA <= 8'hff;
	end
	7:begin Send_State <= 8; SEND_DATA <= mac[47:40]; end
	8:begin Send_State <= 9; SEND_DATA <= mac[39:32]; end	
	9:begin Send_State <= 10; SEND_DATA <= mac[31:24]; end	
	10:begin Send_State <= 11; SEND_DATA <= mac[23:16]; end
	11:begin Send_State <= 12; SEND_DATA <= mac[15:8]; end
	12:begin Send_State <= 13; SEND_DATA <= mac[7:0]; end
	13:begin Send_State <= 14; SEND_DATA <= 8'h08; end
	14:begin Send_State <= 15; SEND_DATA <= 8'h06; end
	15:begin Send_State <= 16; SEND_DATA <= 8'h00; end
	16:begin Send_State <= 17; SEND_DATA <= 8'h01; end
	17:begin Send_State <= 18; SEND_DATA <= 8'h08; end
	18:begin Send_State <= 19; SEND_DATA <= 8'h00; end
	19:begin Send_State <= 20; SEND_DATA <= 8'h06; end
	20:begin Send_State <= 21; SEND_DATA <= 8'h04; end
	21:begin Send_State <= 22; SEND_DATA <= 8'h00; end
	22:begin Send_State <= 23; SEND_DATA <= 8'h01; end
	23:begin Send_State <= 24; SEND_DATA <= mac[47:40]; end
	24:begin Send_State <= 25; SEND_DATA <= mac[39:32]; end	
	25:begin Send_State <= 26; SEND_DATA <= mac[31:24]; end	
	26:begin Send_State <= 27; SEND_DATA <= mac[23:16]; end
	27:begin Send_State <= 28; SEND_DATA <= mac[15:8]; end
	28:begin Send_State <= 29; SEND_DATA <= mac[7:0]; end
	29:begin Send_State <= 30; SEND_DATA <= src_ip[31:24]; end	
	30:begin Send_State <= 31; SEND_DATA <= src_ip[23:16]; end
	31:begin Send_State <= 32; SEND_DATA <= src_ip[15:8]; end
	32:begin Send_State <= 33; SEND_DATA <= src_ip[7:0]; end
	33:begin Send_State <= 34; SEND_DATA <= 8'h84; end
	34:begin Send_State <= 35; SEND_DATA <= 8'h7b; end	
	35:begin Send_State <= 36; SEND_DATA <= 8'heb; end	
	36:begin Send_State <= 37; SEND_DATA <= 8'h48; end
	37:begin Send_State <= 38; SEND_DATA <= 8'h94; end
	38:begin Send_State <= 39; SEND_DATA <= 8'h13; end
	39:begin Send_State <= 40; SEND_DATA <= dst_ip[31:24]; end	
	40:begin Send_State <= 41; SEND_DATA <= dst_ip[23:16]; end
	41:begin Send_State <= 42; SEND_DATA <= dst_ip[15:8]; end
	42:begin Send_State <= 43; SEND_DATA <= dst_ip[7:0]; end
	43:begin Send_State <= 44; SEND_DATA <= 8'h00; end
	44:begin Send_State <= 45; SEND_DATA <= 8'h00; end
	45:begin Send_State <= 46; SEND_DATA <= 8'hff; end
	46:begin Send_State <= 47; SEND_DATA <= 8'hff; end
	47:begin Send_State <= 48; SEND_DATA <= 8'hff; end
	48:begin Send_State <= 49; SEND_DATA <= 8'hff; end
	49:begin Send_State <= 50; SEND_DATA <= 8'hff; end
	50:begin Send_State <= 51; SEND_DATA <= 8'hff; end
	51:begin Send_State <= 52; SEND_DATA <= 8'h00; end
	52:begin Send_State <= 53; SEND_DATA <= 8'h23; end	
	53:begin Send_State <= 54; SEND_DATA <= 8'hcd; end
	54:begin Send_State <= 55; SEND_DATA <= 8'h76; end
	55:begin Send_State <= 56; SEND_DATA <= 8'h63; end
	56:begin Send_State <= 57; SEND_DATA <= 8'h1a; end
	57:begin Send_State <= 58; SEND_DATA <= 8'h08; end
	58:begin Send_State <= 59; SEND_DATA <= 8'h06; end
	59:begin Send_State <= 60; SEND_DATA <= 8'h00; end
	60:begin Send_State <= 61; SEND_DATA <= 8'h01; end	
	61:begin Send_State <= 62; SEND_EN <= 0; end
	62: Send_State <= 63;
	63: if(SENT_BUSY == 0) Send_State <= 0; else Send_State <= 63;
endcase

assign CLK = clk;
assign RST = rst;
endmodule