	nco_test u0 (
		.clk         (<connected-to-clk>),         // clk.clk
		.clken       (<connected-to-clken>),       //  in.clken
		.phi_inc_i   (<connected-to-phi_inc_i>),   //    .phi_inc_i
		.freq_mod_i  (<connected-to-freq_mod_i>),  //    .freq_mod_i
		.phase_mod_i (<connected-to-phase_mod_i>), //    .phase_mod_i
		.fsin_o      (<connected-to-fsin_o>),      // out.fsin_o
		.fcos_o      (<connected-to-fcos_o>),      //    .fcos_o
		.out_valid   (<connected-to-out_valid>),   //    .out_valid
		.reset_n     (<connected-to-reset_n>)      // rst.reset_n
	);

