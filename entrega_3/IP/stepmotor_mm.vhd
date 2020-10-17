library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.numeric_std.all;
use work.all;

entity stepmotor_mm is
    generic (
        LEN  : natural := 4
    );
    port (
        -- Gloabals
        clk                : in  std_logic                     := '0';             
        reset              : in  std_logic                     := '0';             

        -- I/Os
        LEDs               : out std_logic_vector(LEN - 1 downto 0) := (others => '0');

        -- Avalion Memmory Mapped Slave
        avs_address     : in  std_logic_vector(3 downto 0)  := (others => '0'); 
        avs_read        : in  std_logic                     := '0';             
        avs_readdata    : out std_logic_vector(31 downto 0) := (others => '0'); 
        avs_write       : in  std_logic                     := '0';             
        avs_writedata   : in  std_logic_vector(31 downto 0) := (others => '0')
    );
end entity stepmotor_mm;


architecture rtl of stepmotor_mm is

   TYPE STATE_TYPE IS (s0, s1, s2, s3);
   SIGNAL state  : STATE_TYPE := s0;
   signal enable : std_logic  := '0';
   signal topCounter : integer range 0 to 50000000;
  
begin

  process(clk)
  begin
	if(en = '1') then
    if (rising_edge(clk)) then
      CASE state IS
      WHEN s0=>
        if (enable = '1') then
          state <= s1;
        end if;
      WHEN s1=>
        if (enable = '1') then
          state <= s2;
        end if;
      WHEN s2=>
        if (enable = '1') then
          state <= s3;
        end if;
      WHEN s3=>
        if (enable = '1') then
          state <= s0;
        end if;
      when others=>
        state <= s0;
      END CASE;
    end if;
	end if; 
  end process;

  PROCESS (state)
   BEGIN
		if(avs_address = "0001") then
			if (dir = '0') then
				CASE state IS
				  WHEN s0 =>
					 phases <= "0001";
				  WHEN s1 =>
					 phases <= "0010";
				  WHEN s2 =>
					 phases <= "0100";
				  when s3 =>
					 phases <= "1000";
				  when others =>
					 phases <= "0000";
				END CASE;
			else
				CASE state IS
				  WHEN s0 =>
					 phases <= "1000";
				  WHEN s1 =>
					 phases <= "0100";
				  WHEN s2 =>
					 phases <= "0010";
				  when s3 =>
					 phases <= "0001";
				  when others =>
					 phases <= "0000";
				END CASE;
			end if;
		end if;
   END PROCESS;

  topCounter <= 10000000 when vel = "00" else
					 1000000	when vel = "01" else
					 500000 when vel = "10" else
                100000;

  process(clk)
    variable counter : integer range 0 to 50000000 := 0;
  begin
    if (rising_edge(clk)) then
      if (counter < topCounter) then
        counter := counter + 1;
        enable  <= '0';
      else
        counter := 0;
        enable  <= '1';
      end if;
    end if;
  end process;