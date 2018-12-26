	component unsaved is
		port (
			clk_clk       : in    std_logic                    := 'X';             -- clk
			pio_export    : inout std_logic_vector(4 downto 0) := (others => 'X'); -- export
			reset_reset_n : in    std_logic                    := 'X'              -- reset_n
		);
	end component unsaved;

	u0 : component unsaved
		port map (
			clk_clk       => CONNECTED_TO_clk_clk,       --   clk.clk
			pio_export    => CONNECTED_TO_pio_export,    --   pio.export
			reset_reset_n => CONNECTED_TO_reset_reset_n  -- reset.reset_n
		);

