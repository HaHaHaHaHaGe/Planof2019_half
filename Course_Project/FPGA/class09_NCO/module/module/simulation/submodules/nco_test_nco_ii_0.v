//	Copyright (C) 1988-2012 Altera Corporation

//	Any megafunction design, and related net list (encrypted or decrypted),
//	support information, device programming or simulation file, and any other
//	associated documentation or information provided by Altera or a partner
//	under Altera's Megafunction Partnership Program may be used only to
//	program PLD devices (but not masked PLD devices) from Altera.  Any other
//	use of such megafunction design, net list, support information, device
//	programming or simulation file, or any other related documentation or
//	information is prohibited for any other purpose, including, but not
//	limited to modification, reverse engineering, de-compiling, or use with
//	any other silicon devices, unless such use is explicitly licensed under
//	a separate agreement with Altera or a megafunction partner.  Title to
//	the intellectual property, including patents, copyrights, trademarks,
//	trade secrets, or maskworks, embodied in any such megafunction design,
//	net list, support information, device programming or simulation file, or
//	any other related documentation or information provided by Altera or a
//	megafunction partner, remains with Altera, the megafunction partner, or
//	their respective licensors.  No other licenses, including any licenses
//	needed under any third party's intellectual property, are provided herein.


module nco_test_nco_ii_0(clk, reset_n, clken, phi_inc_i, freq_mod_i, phase_mod_i, fsin_o, fcos_o, out_valid);

parameter mpr = 12;
parameter apr = 32;
parameter apri= 16;
parameter aprf= 32;
parameter aprp= 16;
parameter aprid=21;
parameter dpri= 4;
parameter rdw = 11;
parameter raw = 13;
parameter rnw = 8192;
parameter rsf = "nco_test_nco_ii_0_sin.hex";
parameter rcf = "nco_test_nco_ii_0_cos.hex";
parameter nc = 1;
parameter log2nc =0;
parameter outselinit = -1;
parameter paci0= 0;
parameter paci1= 0;
parameter paci2= 0;
parameter paci3= 0;
parameter paci4= 0;
parameter paci5= 0;
parameter paci6= 0;
parameter paci7= 0;
//parameter numba = 1;
//parameter log2numba = 0;

input clk;
input reset_n;
input clken;
input [apr-1:0] phi_inc_i;
input [aprf-1:0] freq_mod_i;
input [aprp-1:0] phase_mod_i;

output [mpr-1:0] fsin_o;
output [mpr-1:0] fcos_o;
output out_valid;
wire reset;
assign reset = !reset_n;

wire [apr-1:0]  phi_inc_i_w;
wire [aprf-1:0] freq_mod_i_w;
wire [aprp-1:0] phase_mod_i_w;
wire [mpr-1:0] sin_rom_2c_w;
wire [mpr-1:0] cos_rom_2c_w;
wire [mpr-2:0] sin_rom_d_w;
wire [mpr-2:0] cos_rom_d_w;
wire [raw-1:0] raxx001w;
wire [apr-1:0] phi_acc_w;
wire [apr-1:0] phi_acc_w_fmi;
wire [apr-1:0] phi_acc_w_fmo;
wire [aprp-1:0] phi_acc_w_pmi;
wire [aprp-1:0] phi_acc_w_pmo;
wire [aprp-1:0] phi_acc_w_t;
wire [aprid-1:0] phi_acc_w_d;
wire [aprid-1:0] phi_acc_w_di;
wire [dpri-1:0]  rval_w_d;
wire [dpri-1:0]  rval_w;
wire [mpr-1:0] sin_o_w;
wire [mpr-1:0] cos_o_w;
wire [mpr-2:0] rxs_w;
wire [mpr-2:0] rxc_w;
wire [mpr-1:0] fsin_o_w;	
wire [mpr-1:0] fcos_o_w;	
wire out_valid_w;
wire [2:0] selector_rot;
wire [2:0] nq;





//Pipelining for Hyper Retimer starts from here
parameter hyper_pipeline = 0;
integer i;

reg [1-1:0] reset_reg [2-1:0];
wire [1-1:0] reset_pipelined;
reg [1-1:0] clken_reg [2-1:0];
wire [1-1:0] clken_pipelined;
reg [apr-1:0] phi_inc_i_reg [2-1:0];
wire [apr-1:0] phi_inc_i_pipelined;
reg [aprf-1:0] freq_mod_i_reg [2-1:0];
wire [aprf-1:0] freq_mod_i_pipelined;
reg [aprp-1:0] phase_mod_i_reg [2-1:0];
wire [aprp-1:0] phase_mod_i_pipelined;
reg [1-1:0] out_valid_w_reg [2-1:0];
wire [1-1:0] out_valid_w_pipelined;
reg [mpr-1:0] fsin_o_w_reg [2-1:0];
wire [mpr-1:0] fsin_o_w_pipelined;
reg [raw-1:0] raxx001w_reg [1-1:0];
wire [raw-1:0] raxx001w_pipelined;
reg [mpr-1-1:0] rxs_w_reg [1-1:0];
wire [mpr-1-1:0] rxs_w_pipelined;
reg [mpr-1-1:0] rxc_w_reg [1-1:0];
wire [mpr-1-1:0] rxc_w_pipelined;
reg [mpr-1:0] fcos_o_w_reg [2-1:0];
wire [mpr-1:0] fcos_o_w_pipelined;
reg [aprid-1:0] phi_acc_w_d_reg [0-1:0];
wire [aprid-1:0] phi_acc_w_d_pipelined;
reg [3-1:0] nq_reg [2-1:0];
wire [3-1:0] nq_pipelined;
reg [3-1:0] selector_rot_reg [1-1:0];
wire [3-1:0] selector_rot_pipelined;
reg [mpr-1-1:0] sin_rom_d_w_reg [1-1:0];
wire [mpr-1-1:0] sin_rom_d_w_pipelined;
reg [mpr-1-1:0] cos_rom_d_w_reg [1-1:0];
wire [mpr-1-1:0] cos_rom_d_w_pipelined;
reg [mpr-1:0] sin_rom_2c_w_reg [1-1:0];
wire [mpr-1:0] sin_rom_2c_w_pipelined;
reg [mpr-1:0] cos_rom_2c_w_reg [1-1:0];
wire [mpr-1:0] cos_rom_2c_w_pipelined;
// Pipeline block
generate
  if (hyper_pipeline == 1) begin
    always @ (posedge clk) begin
      reset_reg[0] <= reset;
      for (i = 1; i < 2; i=i+1) begin
        reset_reg[i] <= reset_reg[i-1];
      end
    end
    assign reset_pipelined = reset_reg[2-1];
  end
  else begin
    assign reset_pipelined = reset; // pipeline for this signal is disabled
  end
endgenerate
// Pipeline block
generate
  if (hyper_pipeline == 1) begin
    always @ (posedge clk) begin
      clken_reg[0] <= clken;
      for (i = 1; i < 2; i=i+1) begin
        clken_reg[i] <= clken_reg[i-1];
      end
    end
    assign clken_pipelined = clken_reg[2-1];
  end
  else begin
    assign clken_pipelined = clken; // pipeline for this signal is disabled
  end
endgenerate
// Pipeline block
generate
  if (hyper_pipeline == 1) begin
    always @ (posedge clk) begin
      phi_inc_i_reg[0] <= phi_inc_i;
      for (i = 1; i < 2; i=i+1) begin
        phi_inc_i_reg[i] <= phi_inc_i_reg[i-1];
      end
    end
    assign phi_inc_i_pipelined = phi_inc_i_reg[2-1];
  end
  else begin
    assign phi_inc_i_pipelined = phi_inc_i; // pipeline for this signal is disabled
  end
endgenerate
// Pipeline block
generate
  if (hyper_pipeline == 1) begin
    always @ (posedge clk) begin
      freq_mod_i_reg[0] <= freq_mod_i;
      for (i = 1; i < 2; i=i+1) begin
        freq_mod_i_reg[i] <= freq_mod_i_reg[i-1];
      end
    end
    assign freq_mod_i_pipelined = freq_mod_i_reg[2-1];
  end
  else begin
    assign freq_mod_i_pipelined = freq_mod_i; // pipeline for this signal is disabled
  end
endgenerate
// Pipeline block
generate
  if (hyper_pipeline == 1) begin
    always @ (posedge clk) begin
      phase_mod_i_reg[0] <= phase_mod_i;
      for (i = 1; i < 2; i=i+1) begin
        phase_mod_i_reg[i] <= phase_mod_i_reg[i-1];
      end
    end
    assign phase_mod_i_pipelined = phase_mod_i_reg[2-1];
  end
  else begin
    assign phase_mod_i_pipelined = phase_mod_i; // pipeline for this signal is disabled
  end
endgenerate
// Pipeline block
generate
  if (hyper_pipeline == 1) begin
    always @ (posedge clk) begin
      out_valid_w_reg[0] <= out_valid_w;
      for (i = 1; i < 2; i=i+1) begin
        out_valid_w_reg[i] <= out_valid_w_reg[i-1];
      end
    end
    assign out_valid_w_pipelined = out_valid_w_reg[2-1];
  end
  else begin
    assign out_valid_w_pipelined = out_valid_w; // pipeline for this signal is disabled
  end
endgenerate
// Pipeline block
generate
  if (hyper_pipeline == 1) begin
    always @ (posedge clk) begin
      fsin_o_w_reg[0] <= fsin_o_w;
      for (i = 1; i < 2; i=i+1) begin
        fsin_o_w_reg[i] <= fsin_o_w_reg[i-1];
      end
    end
    assign fsin_o_w_pipelined = fsin_o_w_reg[2-1];
  end
  else begin
    assign fsin_o_w_pipelined = fsin_o_w; // pipeline for this signal is disabled
  end
endgenerate
// Pipeline block
generate
  if (hyper_pipeline == 1) begin
    always @ (posedge clk) begin
      raxx001w_reg[0] <= raxx001w;
    end
    assign raxx001w_pipelined = raxx001w_reg[1-1];
  end
  else begin
    assign raxx001w_pipelined = raxx001w; // pipeline for this signal is disabled
  end
endgenerate
// Pipeline block
generate
  if (hyper_pipeline == 1) begin
    always @ (posedge clk) begin
      rxs_w_reg[0] <= rxs_w;
    end
    assign rxs_w_pipelined = rxs_w_reg[1-1];
  end
  else begin
    assign rxs_w_pipelined = rxs_w; // pipeline for this signal is disabled
  end
endgenerate
// Pipeline block
generate
  if (hyper_pipeline == 1) begin
    always @ (posedge clk) begin
      rxc_w_reg[0] <= rxc_w;
    end
    assign rxc_w_pipelined = rxc_w_reg[1-1];
  end
  else begin
    assign rxc_w_pipelined = rxc_w; // pipeline for this signal is disabled
  end
endgenerate
// Pipeline block
generate
  if (hyper_pipeline == 1) begin
    always @ (posedge clk) begin
      fcos_o_w_reg[0] <= fcos_o_w;
      for (i = 1; i < 2; i=i+1) begin
        fcos_o_w_reg[i] <= fcos_o_w_reg[i-1];
      end
    end
    assign fcos_o_w_pipelined = fcos_o_w_reg[2-1];
  end
  else begin
    assign fcos_o_w_pipelined = fcos_o_w; // pipeline for this signal is disabled
  end
endgenerate
// Pipeline block
assign phi_acc_w_d_pipelined = phi_acc_w_d; // pipeline for this signal is disabled
// Pipeline block
generate
  if (hyper_pipeline == 1) begin
    always @ (posedge clk) begin
      nq_reg[0] <= nq;
      for (i = 1; i < 2; i=i+1) begin
        nq_reg[i] <= nq_reg[i-1];
      end
    end
    assign nq_pipelined = nq_reg[2-1];
  end
  else begin
    assign nq_pipelined = nq; // pipeline for this signal is disabled
  end
endgenerate
// Pipeline block
generate
  if (hyper_pipeline == 1) begin
    always @ (posedge clk) begin
      selector_rot_reg[0] <= selector_rot;
    end
    assign selector_rot_pipelined = selector_rot_reg[1-1];
  end
  else begin
    assign selector_rot_pipelined = selector_rot; // pipeline for this signal is disabled
  end
endgenerate
// Pipeline block
generate
  if (hyper_pipeline == 1) begin
    always @ (posedge clk) begin
      sin_rom_d_w_reg[0] <= sin_rom_d_w;
    end
    assign sin_rom_d_w_pipelined = sin_rom_d_w_reg[1-1];
  end
  else begin
    assign sin_rom_d_w_pipelined = sin_rom_d_w; // pipeline for this signal is disabled
  end
endgenerate
// Pipeline block
generate
  if (hyper_pipeline == 1) begin
    always @ (posedge clk) begin
      cos_rom_d_w_reg[0] <= cos_rom_d_w;
    end
    assign cos_rom_d_w_pipelined = cos_rom_d_w_reg[1-1];
  end
  else begin
    assign cos_rom_d_w_pipelined = cos_rom_d_w; // pipeline for this signal is disabled
  end
endgenerate
// Pipeline block
generate
  if (hyper_pipeline == 1) begin
    always @ (posedge clk) begin
      sin_rom_2c_w_reg[0] <= sin_rom_2c_w;
    end
    assign sin_rom_2c_w_pipelined = sin_rom_2c_w_reg[1-1];
  end
  else begin
    assign sin_rom_2c_w_pipelined = sin_rom_2c_w; // pipeline for this signal is disabled
  end
endgenerate
// Pipeline block
generate
  if (hyper_pipeline == 1) begin
    always @ (posedge clk) begin
      cos_rom_2c_w_reg[0] <= cos_rom_2c_w;
    end
    assign cos_rom_2c_w_pipelined = cos_rom_2c_w_reg[1-1];
  end
  else begin
    assign cos_rom_2c_w_pipelined = cos_rom_2c_w; // pipeline for this signal is disabled
  end
endgenerate


asj_xnqg u011(.phi_a(phi_acc_w_t),
             .xnq(nq)
             );
defparam u011.apr=aprp;


segment_arr_tdl tdl( .clk(clk),
                     .reset(reset_pipelined),
                     .clken(clken_pipelined), 
                     .current_seg(nq_pipelined),
                     .seg_rot(selector_rot)
                      );
defparam tdl.npiperom = 2;
defparam tdl.npiperot = 4;

assign phi_acc_w_fmi = phi_inc_i_pipelined[apr-1:0];
assign freq_mod_i_w = freq_mod_i_pipelined;
assign phi_inc_i_w = phi_acc_w_fmo;

asj_nco_fxx ux003(.clk(clk),
             .reset(reset_pipelined),
             .clken(clken_pipelined),
             .phi_acc(phi_acc_w_fmi),
             .phi_mod_int(freq_mod_i_w),
             .phi_out(phi_acc_w_fmo)
             );
defparam ux003.apr = apr;
defparam ux003.aprf = aprf;
defparam ux003.pipeline = 1;

asj_altqmcpipe ux000 (.clk(clk),
             .reset(reset_pipelined),
             .clken(clken_pipelined),
             .phi_inc_int(phi_inc_i_w),
             .phi_acc_reg(phi_acc_w)
             );

defparam ux000.nc = nc ;
defparam ux000.apr = apr ;
defparam ux000.lat = 1 ;
defparam ux000.paci0 = paci0 ;
defparam ux000.paci1 = paci1 ;
defparam ux000.paci2 = paci2 ;
defparam ux000.paci3 = paci3 ;
defparam ux000.paci4 = paci4 ;
defparam ux000.paci5 = paci5 ;
defparam ux000.paci6 = paci6 ;
defparam ux000.paci7 = paci7 ;

asj_dxx_g ux001(.clk(clk),
            .clken(clken_pipelined),
              .reset(reset_pipelined),
              .dxxrv(rval_w_d)
              );
defparam ux001.dpri = dpri;
assign rval_w = rval_w_d;
asj_dxx ux002(.clk(clk),
            .clken(clken_pipelined),
	         .reset(reset_pipelined),
            .dxxpdi(phi_acc_w_di),
            .rval(rval_w),
            .dxxpdo(phi_acc_w_d)
           );

defparam ux002.aprid = aprid;
defparam ux002.dpri = dpri;

asj_nco_apr_dxx ux0219(.pcc_w(phi_acc_w),
                         .pcc_d(phi_acc_w_di)
                         );
defparam ux0219.apr = apr;
defparam ux0219.aprid = aprid;


assign phi_acc_w_pmi = phi_acc_w_d_pipelined[aprid-1:aprid-aprp];
assign phase_mod_i_w = phase_mod_i_pipelined;
assign phi_acc_w_t = phi_acc_w_pmo[aprp-1:0];

asj_nco_pxx ux004(.clk(clk),
             .reset(reset_pipelined),
             .clken(clken_pipelined),
             .phi_acc(phi_acc_w_pmi),
             .phi_mod_int(phase_mod_i_w),
             .phi_out(phi_acc_w_pmo)
             );

defparam ux004.aprp = aprp;
defparam ux004.pipeline = 1;
defparam ux004.depth = 4;

asj_gar ux007( .clk(clk),
                   .reset(reset_pipelined),
                   .phi_acc_w(phi_acc_w_t[aprp-4:aprp-3-raw]),
                   .clken(clken_pipelined),
                   .segment_lsb(nq[0]),
                   .rom_add(raxx001w)
                   );
defparam ux007.raw = raw;
defparam ux007.apr = apri;

sid_2c_1p sid2c(.clk(clk),
                .reset(reset_pipelined),
                .clken(clken_pipelined),
                .sin_rom(rxs_w_pipelined),
                .cos_rom(rxc_w_pipelined),
                .sin_rom_2c(sin_rom_2c_w),
                .cos_rom_2c(cos_rom_2c_w),
                .sin_rom_d(sin_rom_d_w),
                .cos_rom_d(cos_rom_d_w)
                );

defparam sid2c.mpr = mpr;

asj_nco_as_m_cen ux0120(.clk(clk),
                   .clken (clken_pipelined),
                   .raxx (raxx001w_pipelined[raw-1:0]),
                   .srw_int_res(rxs_w[mpr-2:0])
                    );

defparam ux0120.mpr = mpr;
defparam ux0120.rdw = rdw;
defparam ux0120.raw = raw;
defparam ux0120.rnw = rnw;
defparam ux0120.rf = rsf;
defparam ux0120.dev = "Cyclone IV E";

asj_nco_as_m_cen ux0121(.clk(clk),
                   .clken (clken_pipelined),
                   .raxx (raxx001w_pipelined[raw-1:0]),
                   .srw_int_res(rxc_w[mpr-2:0])
                    );

defparam ux0121.mpr = mpr;
defparam ux0121.rdw = rdw;
defparam ux0121.raw = raw;
defparam ux0121.rnw = rnw;
defparam ux0121.rf = rcf;
defparam ux0121.dev = "Cyclone IV E";

segment_sel  rot(.clk(clk),
                 .reset(reset_pipelined),
                 .clken(clken_pipelined),
                 .segment(selector_rot_pipelined),
                 .sin_rom_d(sin_rom_d_w_pipelined),
                 .cos_rom_d(cos_rom_d_w_pipelined),
                 .sin_rom_2c(sin_rom_2c_w_pipelined),
                 .cos_rom_2c(cos_rom_2c_w_pipelined),
                 .sin_o(sin_o_w),
                 .cos_o(cos_o_w)
		     );

defparam rot.mpr = mpr;

asj_nco_mob_rw ux122(.data_in(sin_o_w),
                     .data_out(fsin_o_w),
                     .reset(reset_pipelined),
                     .clken(clken_pipelined),
                     .clk(clk)
);
defparam ux122.mpr = mpr;
defparam ux122.sel = 0;
asj_nco_mob_rw ux123(.data_in(cos_o_w),
                     .data_out(fcos_o_w),
                     .reset(reset_pipelined),
                     .clken(clken_pipelined),
                     .clk(clk)
);
defparam ux123.mpr = mpr;
defparam ux123.sel = 0;
assign fsin_o = fsin_o_w_pipelined;
assign fcos_o = fcos_o_w_pipelined;



asj_nco_isdr ux710isdr(.clk(clk),
                    .reset(reset_pipelined),
                    .clken(clken_pipelined),
                    .data_ready(out_valid_w)
                    );
defparam ux710isdr.ctc=11;
defparam ux710isdr.cpr=4;
assign out_valid = out_valid_w_pipelined;



endmodule
