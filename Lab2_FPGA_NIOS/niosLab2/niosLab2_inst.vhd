	component niosLab2 is
		port (
			clk_clk      : in  std_logic                    := 'X'; -- clk
			dir_export   : in  std_logic                    := 'X'; -- export
			en_export    : in  std_logic                    := 'X'; -- export
			leds_export  : out std_logic_vector(5 downto 0);        -- export
			motor_export : out std_logic_vector(3 downto 0)         -- export
		);
	end component niosLab2;

	u0 : component niosLab2
		port map (
			clk_clk      => CONNECTED_TO_clk_clk,      --   clk.clk
			dir_export   => CONNECTED_TO_dir_export,   --   dir.export
			en_export    => CONNECTED_TO_en_export,    --    en.export
			leds_export  => CONNECTED_TO_leds_export,  --  leds.export
			motor_export => CONNECTED_TO_motor_export  -- motor.export
		);

