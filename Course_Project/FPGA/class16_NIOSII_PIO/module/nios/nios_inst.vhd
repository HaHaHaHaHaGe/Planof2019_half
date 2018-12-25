	component nios is
		port (
			clk_clk     : in    std_logic                    := 'X';             -- clk
			led_export  : inout std_logic_vector(4 downto 0) := (others => 'X'); -- export
			rst_reset_n : in    std_logic                    := 'X'              -- reset_n
		);
	end component nios;

	u0 : component nios
		port map (
			clk_clk     => CONNECTED_TO_clk_clk,     -- clk.clk
			led_export  => CONNECTED_TO_led_export,  -- led.export
			rst_reset_n => CONNECTED_TO_rst_reset_n  -- rst.reset_n
		);

