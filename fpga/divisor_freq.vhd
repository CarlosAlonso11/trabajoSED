library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity clock_divider is
    Port (
        clk_in   : in  std_logic; -- Reloj de 100 MHz
        clk_out  : out std_logic  -- Señal de 1 Hz
    );
end clock_divider;

architecture Behavioral of clock_divider is
    constant DIVISOR : integer := 100_000_000; -- Divisor para 1 Hz
    signal counter   : integer range 0 to DIVISOR - 1 := 0;
    signal clk_1hz   : std_logic := '0';
begin
    process(clk_in)
    begin
       if rising_edge(clk_in) then
          if counter = DIVISOR - 1 then
              counter <= 0;
              clk_1hz <= not clk_1hz;
          else
              counter <= counter + 1;
          end if;
       end if;
    end process;

    clk_out <= clk_1hz;

end Behavioral;
