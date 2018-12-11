module RTL8201_MII_MAC(
	//ETH_TX_ER,
	ETH_TX_EN,
	ETH_TX_CLK,
	ETH_TX_DATA,
	//ETH_MDC,
	//ETH_MDIO,
	
	ETH_RST_N,
	
	ETH_RX_DV,
	ETH_RX_ER,
	ETH_RX_CLK,
	ETH_RX_DATA,
	//ETH_COL,
	ETH_CRS,
	
	
	
	SEND_DATA,
	SENT_BUSY,
	SEND_EN,
	CLK,
	RST
);



wire [7:0]RAM_OUT;

reg wren;


reg [10:0]rdaddress;
reg [10:0]wraddress;
RTL8201_RAM RTL8201_RAM1 (
	.data(SEND_DATA),
	.rdaddress(rdaddress),
	.rdclock(ETH_TX_CLK),
	.wraddress(wraddress),
	.wrclock(CLK),
	.wren(wren),
	.q(RAM_OUT)
);


reg [31:0]CRC32_in;
wire [31:0]CRC32_out;





is_crc32_8bit is_crc32_8bit1(
	.data(SEND_DATA), 
	.in(CRC32_in), 
	.xor_out(CRC32_out)
);


input ETH_TX_CLK,ETH_RX_ER,ETH_RX_DV,ETH_RX_CLK,ETH_CRS,ETH_CRS;
input [3:0]ETH_RX_DATA;

//output ETH_TX_ER;
output reg ETH_TX_EN;
output reg [3:0]ETH_TX_DATA;

input CLK,RST,SEND_EN;
input [7:0]SEND_DATA;
output reg SENT_BUSY;

output ETH_RST_N;

localparam SEND_STATE_IDLE = 0;
localparam SEND_STATE_RECV = 1;
localparam SEND_STATE_ETH = 2;

reg [1:0]SEND_STATE;
reg [4:0]Toggle_Send;

always@(posedge CLK,negedge RST)
if(!RST) begin
	SEND_STATE <= SEND_STATE_IDLE;
	SENT_BUSY <= 1'b0;
	CRC32_in <= 32'h0;
	wren <= 1'b0;
	wraddress <= 11'b0;
end
else case(SEND_STATE)
	SEND_STATE_IDLE:
		if(SEND_EN) begin
			SEND_STATE <= SEND_STATE_RECV;
			wren <= 1'b1;
			CRC32_in <= 32'h0;
			SENT_BUSY <= 1'b1;
			wraddress <= 11'b0;
		end
		else begin
			SENT_BUSY <= 1'b0;
		end
	SEND_STATE_RECV:
		if(SEND_EN) begin	
			CRC32_in <= CRC32_out;
			wraddress <= wraddress + 11'b1;
		end
		else begin
			wren <= 1'b0;
			SEND_STATE <= SEND_STATE_ETH;
		end
	SEND_STATE_ETH:
		if(Toggle_Send == 5'd27) begin
			SEND_STATE <= SEND_STATE_IDLE;
		end
		else begin
			SENT_BUSY <= 1'b1;
		end
	default: SEND_STATE <= SEND_STATE_IDLE;
endcase



always@(posedge ETH_TX_CLK,negedge RST)
if(!RST) begin
	ETH_TX_DATA <= 4'b0;
	Toggle_Send <= 5'b0;
	ETH_TX_EN <= 1'b0;
	rdaddress <= 11'b0;
end
else case(Toggle_Send)
	0:
	if(SEND_STATE == SEND_STATE_ETH) begin
		ETH_TX_EN <= 1'b1;
		Toggle_Send <= 5'd1;
		ETH_TX_DATA <= 4'h5;
		rdaddress <= 11'b0;
	end
	else
		ETH_TX_EN <= 1'b0;
	1,2,3,4,5,6,7,8,9,10,11,12,13,14:
		Toggle_Send <= Toggle_Send + 5'd1;

	15:begin
		ETH_TX_DATA <= 4'hd;
		Toggle_Send <= 5'd16;

	end

	16:
	begin

			rdaddress <= rdaddress + 11'b1;
			ETH_TX_DATA <= RAM_OUT[3:0];
			Toggle_Send <= 5'd17;

	end
	17:
	if(rdaddress == wraddress) begin
			Toggle_Send <= 5'd18;
			ETH_TX_DATA <= RAM_OUT[7:4];
		end
	else 
	begin
		ETH_TX_DATA <= RAM_OUT[7:4];
		Toggle_Send <= 5'd16;
	end
	18:
	begin
		Toggle_Send <= 5'd19;
		ETH_TX_DATA <= CRC32_in[3:0];
	end
	
	19:
	begin
		ETH_TX_DATA <= CRC32_in[7:4];
		Toggle_Send <= 5'd20;
	end
	20:
	begin
		ETH_TX_DATA <= CRC32_in[11:8];
		Toggle_Send <= 5'd21;
	end
	21:
	begin
		ETH_TX_DATA <= CRC32_in[15:12];
		Toggle_Send <= 5'd22;
	end
	22:
	begin
		ETH_TX_DATA <= CRC32_in[19:16];
		Toggle_Send <= 5'd23;
	end
	23:
	begin
		ETH_TX_DATA <= CRC32_in[23:20];
		Toggle_Send <= 5'd24;
	end	
	24:
	begin
		ETH_TX_DATA <= CRC32_in[27:24];
		Toggle_Send <= 5'd25;
	end
	25:
	begin
		ETH_TX_DATA <= CRC32_in[31:28];
		Toggle_Send <= 5'd26;
	end
	26:
	begin
		ETH_TX_EN <= 1'b0;
		Toggle_Send <= 5'd27;
	end
	27:
	begin
		Toggle_Send <= 5'd0;
	end
endcase

assign ETH_RST_N = RST;
endmodule