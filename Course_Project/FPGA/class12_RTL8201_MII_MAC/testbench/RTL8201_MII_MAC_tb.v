`timescale 1ns/1ns
module RTL8201_MII_MAC_tb();

wire ETH_TX_EN,ETH_RST_N,SENT_BUSY;
reg ETH_TX_CLK,SEND_EN,CLK,RST;
wire [3:0]ETH_TX_DATA;
reg [7:0]SEND_DATA;
RTL8201_MII_MAC RTL8201_MII_MAC1(
	//.ETH_TX_ER(),
	.ETH_TX_EN(ETH_TX_EN),
	.ETH_TX_CLK(ETH_TX_CLK),
	.ETH_TX_DATA(ETH_TX_DATA),
	//ETH_MDC,
	//ETH_MDIO,
	
	.ETH_RST_N(ETH_RST_N),
	
	.ETH_RX_DV(),
	.ETH_RX_ER(),
	.ETH_RX_CLK(),
	.ETH_RX_DATA(),
	//ETH_COL,
	.ETH_CRS(),
	
	
	
	.SEND_DATA(SEND_DATA),
	.SENT_BUSY(SENT_BUSY),
	.SEND_EN(SEND_EN),
	.CLK(CLK),
	.RST(RST)
);

initial begin
	ETH_TX_CLK <= 0;
	SEND_EN <= 0;
	CLK <= 0;
	RST <= 1;
	SEND_DATA <= 8'b0;
end

always #10 CLK <= ~CLK;
always #22 ETH_TX_CLK <= ~ETH_TX_CLK;

initial begin
#100;
RST <= 0;
#100;
RST <= 1;
#100;

SEND_EN <= 1;
#20;
SEND_DATA <= 8'h11;
#20;
SEND_DATA <= 8'h22;
#20;
SEND_DATA <= 8'h33;
#20;
SEND_DATA <= 8'h44;
#20;
SEND_DATA <= 8'h55;
#20;
SEND_DATA <= 8'h66;
#20;



SEND_DATA <= 8'h00;
#20;
SEND_DATA <= 8'h0a;
#20;
SEND_DATA <= 8'h35;
#20;
SEND_DATA <= 8'h01;
#20;
SEND_DATA <= 8'hfe;
#20;
SEND_DATA <= 8'hc0;
#20;


SEND_DATA <= 8'h08;
#20;
SEND_DATA <= 8'h06;
#20;
SEND_DATA <= 8'h00;
#20;
SEND_DATA <= 8'h01;
#20;

SEND_DATA <= 8'h08;
#20;
SEND_DATA <= 8'h00;
#20;
SEND_DATA <= 8'h06;
#20;
SEND_DATA <= 8'h04;
#20;
SEND_DATA <= 8'h00;
#20;
SEND_DATA <= 8'h01;
#20;


SEND_DATA <= 8'h00;
#20;
SEND_DATA <= 8'h0a;
#20;
SEND_DATA <= 8'h35;
#20;
SEND_DATA <= 8'h01;
#20;
SEND_DATA <= 8'hfe;
#20;
SEND_DATA <= 8'hc0;
#20;

SEND_DATA <= 8'hc0;
#20;
SEND_DATA <= 8'ha8;
#20;
SEND_DATA <= 8'h00;
#20;
SEND_DATA <= 8'h02;
#20;
SEND_DATA <= 8'h84;
#20;
SEND_DATA <= 8'h7b;
#20;
SEND_DATA <= 8'heb;
#20;
SEND_DATA <= 8'h48;
#20;
SEND_DATA <= 8'h94;
#20;
SEND_DATA <= 8'h13;
#20;
SEND_DATA <= 8'hc0;
#20;
SEND_DATA <= 8'ha8;
#20;

SEND_DATA <= 8'h00;
#20;
SEND_DATA <= 8'h03;
#20;
SEND_DATA <= 8'h00;
#20;
SEND_DATA <= 8'h00;
#20;


SEND_DATA <= 8'hff;
#20;
SEND_DATA <= 8'hff;
#20;
SEND_DATA <= 8'hff;
#20;
SEND_DATA <= 8'hff;
#20;
SEND_DATA <= 8'hff;
#20;
SEND_DATA <= 8'hff;
#20;

SEND_DATA <= 8'h00;
#20;
SEND_DATA <= 8'h23;
#20;
SEND_DATA <= 8'hcd;
#20;
SEND_DATA <= 8'h76;
#20;
SEND_DATA <= 8'h63;
#20;
SEND_DATA <= 8'h1a;
#20;


SEND_DATA <= 8'h08;
#20;
SEND_DATA <= 8'h06;
#20;
SEND_DATA <= 8'h00;
#20;
SEND_DATA <= 8'h01;
#20;


SEND_EN <= 0;
@(negedge SENT_BUSY);
#500;
$stop;
end
endmodule