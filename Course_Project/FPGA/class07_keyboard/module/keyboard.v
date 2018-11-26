module keyboard(
	clk,
	rst,
	keyout,
	line_in,
	line_out,
);
input clk,rst;
input [3:0]line_in;

output [15:0]keyout;
output reg [3:0]line_out;

reg [3:0]in_1;
reg [3:0]in_2;

reg [15:0]line_in_out;






pushkey pushkey1(
	.clk(clk),
	.key(line_in_out[0]),
	.out(keyout[0])
);
pushkey pushkey2(
	.clk(clk),
	.key(line_in_out[1]),
	.out(keyout[1])
);
pushkey pushkey3(
	.clk(clk),
	.key(line_in_out[2]),
	.out(keyout[2])
);
pushkey pushkey4(
	.clk(clk),
	.key(line_in_out[3]),
	.out(keyout[3])
);





pushkey pushkey5(
	.clk(clk),
	.key(line_in_out[4]),
	.out(keyout[4])
);
pushkey pushkey6(
	.clk(clk),
	.key(line_in_out[5]),
	.out(keyout[5])
);
pushkey pushkey7(
	.clk(clk),
	.key(line_in_out[6]),
	.out(keyout[6])
);
pushkey pushkey8(
	.clk(clk),
	.key(line_in_out[7]),
	.out(keyout[7])
);




pushkey pushkey9(
	.clk(clk),
	.key(line_in_out[8]),
	.out(keyout[8])
);
pushkey pushkey10(
	.clk(clk),
	.key(line_in_out[9]),
	.out(keyout[9])
);
pushkey pushkey11(
	.clk(clk),
	.key(line_in_out[10]),
	.out(keyout[10])
);
pushkey pushkey12(
	.clk(clk),
	.key(line_in_out[11]),
	.out(keyout[11])
);



pushkey pushkey13(
	.clk(clk),
	.key(line_in_out[12]),
	.out(keyout[12])
);
pushkey pushkey14(
	.clk(clk),
	.key(line_in_out[13]),
	.out(keyout[13])
);
pushkey pushkey15(
	.clk(clk),
	.key(line_in_out[14]),
	.out(keyout[14])
);
pushkey pushkey16(
	.clk(clk),
	.key(line_in_out[15]),
	.out(keyout[15])
);











always@(posedge clk,negedge rst)
if(!rst) begin
	in_1 <= 4'b0;
	in_2 <= 4'b0;
end
else begin
	in_1 <= line_in;
	in_2 <= in_1;
end


always@(posedge clk, negedge rst)
if(!rst) begin
	line_in_out <= 15'b0;
	line_out <= 4'b1110;
end
else begin
	line_out <= {line_out[2:0],line_out[3]};
	case(line_out)
		4'b1110:line_in_out[3:0] <= in_2;
		4'b1101:line_in_out[7:4] <= in_2;
		4'b1011:line_in_out[11:8] <= in_2;
		4'b0111:line_in_out[15:12] <= in_2;
		default:line_out<=4'b1110;
	endcase
	
end

endmodule