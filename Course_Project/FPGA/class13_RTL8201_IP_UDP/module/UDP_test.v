module UDP_test(
	clk,
	rst,
	
	ETH_TX_EN,
	ETH_TX_CLK,
	ETH_TX_DATA,
	ETH_RST_N
);

input clk,rst,ETH_TX_CLK;
output ETH_TX_EN,ETH_RST_N;
output [3:0]ETH_TX_DATA;

wire [7:0]SEND_DATA;
wire SENT_BUSY,SEND_EN;




reg [7:0]data;
wire busy;
reg start;


IP IP1(
	.src_mac(48'h00_0a_35_01_fe_c0),
	.dst_mac(48'h0c_9d_92_85_d4_a3),
	.src_ip(32'hc0_a8_00_02),
	.dst_ip(32'hc0_a8_00_03),
	.data(data),
	.data_type(8'h11),
	.len(16'h1e),
	.start(start),
	.busy(busy),
	.clk(clk),
	.rst(rst),
	
	.SEND_DATA(SEND_DATA),
	.SENT_BUSY(SENT_BUSY),
	.SEND_EN(SEND_EN)

);


RTL8201_MII_MAC RTL8201_MII_MAC1(
	.ETH_TX_EN(ETH_TX_EN),
	.ETH_TX_CLK(ETH_TX_CLK),
	.ETH_TX_DATA(ETH_TX_DATA),
	.ETH_RST_N(ETH_RST_N),
	.ETH_RX_DV(),
	.ETH_RX_ER(),
	.ETH_RX_CLK(),
	.ETH_RX_DATA(),
	.ETH_CRS(),

	.SEND_DATA(SEND_DATA),
	.SENT_BUSY(SENT_BUSY),
	.SEND_EN(SEND_EN),
	.CLK(clk),
	.RST(rst)
);


reg [7:0]sendflag;
reg [31:0]cnt;


always@(posedge clk,negedge rst)
if(!rst) begin
	sendflag <= 0;
	start <= 0;
	data <= 0;
	cnt <= 0;
end
else case (sendflag)
	0:if(cnt == 32'd10_000_000) begin
			sendflag <= 1;
			start <= 1;
			cnt <= 0;
		end
		else begin
			sendflag <= 0;
			cnt <= cnt + 1;
		end
	1:begin sendflag <= 2; data <= 8'h13;end
	2:begin sendflag <= 3; data <= 8'h88;end
	
	3:begin sendflag <= 4; data <= 8'h17;end
	4:begin sendflag <= 5; data <= 8'h70;end
	
	5:begin sendflag <= 6; data <= 8'h00;end
	6:begin sendflag <= 7; data <= 8'h1e;end
	
	7:begin sendflag <= 8; data <= 8'h00;end
	8:begin sendflag <= 9; data <= 8'h00;end
	
	9:begin sendflag <= 10; data <= 8'h48;end
	10:begin sendflag <= 11; data <= 8'h65;end
	11:begin sendflag <= 12; data <= 8'h6c;end
	12:begin sendflag <= 13; data <= 8'h6c;end
	13:begin sendflag <= 14; data <= 8'h6f;end
	14:begin sendflag <= 15; data <= 8'h2c;end
	15:begin sendflag <= 16; data <= 8'h20;end
	16:begin sendflag <= 17; data <= 8'h77;end
	17:begin sendflag <= 18; data <= 8'h65;end
	18:begin sendflag <= 19; data <= 8'h6c;end
	19:begin sendflag <= 20; data <= 8'h63;end
	20:begin sendflag <= 21; data <= 8'h6f;end
	21:begin sendflag <= 22; data <= 8'h6d;end
	
	22:begin sendflag <= 23; data <= 8'h20;end
	23:begin sendflag <= 24; data <= 8'h74;end
	24:begin sendflag <= 25; data <= 8'h6f;end
	25:begin sendflag <= 26; data <= 8'h20;end
	26:begin sendflag <= 27; data <= 8'h46;end
	
	27:begin sendflag <= 28; data <= 8'h50;end
	28:begin sendflag <= 29; data <= 8'h47;end
	29:begin sendflag <= 30; data <= 8'h41;end
	30:begin sendflag <= 31; data <= 8'h21;end
	31:begin sendflag <= 32; start <= 0;end
	32:begin sendflag <= 0;  end
endcase


endmodule
