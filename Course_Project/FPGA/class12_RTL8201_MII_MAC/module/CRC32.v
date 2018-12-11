module is_crc32_8bit(
	data, 
	in,
	xor_out
);
input [7:0]data;
wire [7:0] d;
output [31:0] xor_out;
input [31:0] in;
wire [31:0] r;
wire [7:0] temr;
assign d = {data[0],data[1],data[2],data[3],data[4],data[5],data[6],data[7]};
assign r = ~{in[0],in[1],in[2],in[3],in[4],in[5],in[6],in[7],in[8],in[9],in[10],in[11],in[12],in[13],in[14],in[15],in[16],in[17],in[18],in[19],in[20],in[21],in[22],in[23],in[24],in[25],in[26],in[27],in[28],in[29],in[30],in[31]};
assign temr[0] = d[0] ^ d[6] ^ r[30] ^ r[24];
assign temr[1] = d[1] ^ d[7] ^ r[25] ^ r[31] ^ temr[0];
assign temr[2] = d[7] ^ d[6];
assign temr[3] = d[5] ^ d[4];
assign temr[4] = d[3] ^ d[2];
assign temr[5] = r[31] ^ r[30];
assign temr[6] = r[29] ^ r[28];
assign temr[7] = r[27] ^ r[26];
assign xor_out[31]  = ~(temr[0]);
assign xor_out[30]  = ~(temr[1]);
assign xor_out[29]  = ~(temr[1] ^ d[2] ^ r[26]);
assign xor_out[28]  = ~(temr[4] ^ temr[7] ^ d[7] ^ d[1] ^ r[31] ^ r[25]);
assign xor_out[27]  = ~(temr[0] ^ temr[4] ^ temr[7] ^ d[4] ^ r[28]);
assign xor_out[26]  = ~(temr[1] ^ temr[3] ^ temr[6] ^ d[3] ^ r[27]);
assign xor_out[25]  = ~(temr[2] ^ temr[3] ^ temr[5] ^ temr[6] ^ d[2] ^ d[1] ^ r[26] ^ r[25]);
assign xor_out[24]  = ~(temr[0] ^ temr[2] ^ temr[4] ^ temr[5] ^ temr[7] ^ d[5] ^ r[29]);
assign xor_out[23]  = ~(temr[1] ^ temr[2] ^ temr[5] ^ d[4] ^ d[3] ^ r[0] ^ r[28] ^ r[27]);
assign xor_out[22]  = ~(temr[3] ^ temr[6] ^ d[2] ^ d[1] ^ r[26] ^ r[25] ^ r[1]);
assign xor_out[21]  = ~(temr[0] ^ temr[4] ^ temr[7] ^ d[6] ^ d[5] ^ r[30] ^ r[29] ^ r[2]);
assign xor_out[20]  = ~(temr[1] ^ temr[2] ^ temr[5] ^ d[4] ^ d[3] ^ r[28] ^ r[27] ^ r[3]);
assign xor_out[19]  = ~(temr[1] ^ temr[3] ^ temr[6] ^ d[7] ^ d[2] ^ r[31] ^ r[26] ^ r[4]);
assign xor_out[18]  = ~(temr[2] ^ temr[4] ^ temr[5] ^ temr[7] ^ d[5] ^ d[1] ^ r[29] ^ r[25] ^ r[5]);
assign xor_out[17]  = ~(temr[2] ^ temr[4] ^ temr[5] ^ temr[7] ^ d[4] ^ r[28] ^ r[6]);
assign xor_out[16]  = ~(temr[3] ^ temr[6] ^ d[7] ^ d[3] ^ r[31] ^ r[27] ^ r[7]);
assign xor_out[15]  = ~(temr[0] ^ temr[3] ^ temr[6] ^ d[6] ^ r[30] ^ r[8]);
assign xor_out[14]  = ~(d[6] ^ d[5] ^ d[1] ^ r[30] ^ r[29] ^ r[25] ^ r[9]);
assign xor_out[13]  = ~(temr[2] ^ temr[5] ^ d[2] ^ r[26] ^ r[10]);
assign xor_out[12]  = ~(d[7] ^ d[3] ^ r[31] ^ r[27] ^ r[11]);
assign xor_out[11]  = ~(d[4] ^ r[28] ^ r[12]);
assign xor_out[10]  = ~(d[5] ^ r[29] ^ r[13]);
assign xor_out[9]  = ~(temr[0] ^ d[6] ^ r[30] ^ r[14]);
assign xor_out[8]  = ~(temr[1] ^ d[7] ^ r[31] ^ r[15]);
assign xor_out[7]  = ~(d[7] ^ d[2] ^ d[1] ^ r[31] ^ r[26] ^ r[25] ^ r[16]);
assign xor_out[6]  = ~(temr[4] ^ temr[7] ^ r[17]);
assign xor_out[5]  = ~(temr[0] ^ d[4] ^ d[3] ^ r[28] ^ r[27] ^ r[18]);
assign xor_out[4]  = ~(temr[3] ^ temr[6] ^ d[7] ^ d[1] ^ r[31] ^ r[25] ^ r[19]);
assign xor_out[3]  = ~(d[6] ^ d[5] ^ d[2] ^ r[30] ^ r[29] ^ r[26] ^ r[20]);
assign xor_out[2]  = ~(temr[2] ^ temr[5] ^ d[3] ^ r[27] ^ r[21]);
assign xor_out[1]  = ~(d[7] ^ d[4] ^ r[31] ^ r[28] ^ r[22]);
assign xor_out[0]  = ~(d[5] ^ r[29] ^ r[23]);
endmodule 
