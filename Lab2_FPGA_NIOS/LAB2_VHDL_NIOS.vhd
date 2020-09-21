library IEEE;
use IEEE.std_logic_1164.all;

entity LAB2_VHDL_NIOS is
    port (
        -- Gloabals
        fpga_clk_50        : in  std_logic;		  -- clock.clk
		  
		  fpga_en_pio			: in std_logic;
		  
		  fpga_dir_pio			: in std_logic;
		  
		  fpga_motor_pio       : out std_logic_vector(3 downto 0);
		  
        -- I/Os
        fpga_led_pio       : out std_logic_vector(5 downto 0)
  );
end entity LAB2_VHDL_NIOS;

architecture rtl of LAB2_VHDL_NIOS is

    component niosLab2 is
        port (
            clk_clk     : in  std_logic                    := 'X';             -- clk
            dir_export  : in  std_logic                    := 'X';
				en_export   : in  std_logic                    := 'X';             -- export
				motor_export : out std_logic_vector(3 downto 0);
            leds_export : out std_logic_vector(5 downto 0)                     -- export
        );
    end component niosLab2;

    begin

		u0 : component niosLab2
        port map (
            clk_clk     => fpga_clk_50,     --  clk.clk
            dir_export  => fpga_dir_pio,  --  dir.export
            en_export   => fpga_en_pio,   --   en.export
            leds_export => fpga_led_pio,  -- leds.export
				motor_export => fpga_motor_pio  -- motor.export
        );

	end rtl;