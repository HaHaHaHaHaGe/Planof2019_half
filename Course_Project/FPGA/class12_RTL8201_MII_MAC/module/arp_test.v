module arp_test(
	clk,
	rst,
	
	ETH_TX_EN,
	ETH_TX_CLK,
	ETH_TX_DATA,
	ETH_RST_N
);

input clk,rst,ETH_TX_CLK;
output [3:0]ETH_TX_DATA;
output ETH_TX_EN,ETH_RST_N;

wire [7:0]SEND_DATA;
wire SENT_BUSY,CLK,RST;
wire busy,SEND_EN;
reg start;
ARP ARP1(
	.mac_addr(48'h12_34_56_78_90_ab),
	.src_ip(32'hc0_a8_00_09),
	.dst_ip(32'hc0_a8_00_03),
	.start(start),
	.busy(busy),
	.clk(clk),
	.rst(rst),
	
	.SEND_DATA(SEND_DATA),
	.SENT_BUSY(SENT_BUSY),
	.SEND_EN(SEND_EN),
	.CLK(CLK),
	.RST(RST)
);



RTL8201_MII_MAC RTL8201_MII_MAC1(
	//ETH_TX_ER,
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

reg [31:0]cnt;
always@(posedge clk,negedge rst) begin
if(!rst) begin
	cnt <= 0;
	start <= 0;
end
else if(cnt == 32'd10_000_000) begin
	start <= 1;
	cnt <= 0;
end
else begin
	start <= 0;
	
	cnt <= cnt + 1;
end
end

endmodule