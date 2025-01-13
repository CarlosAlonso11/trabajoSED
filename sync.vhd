LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY sync IS
    PORT (
        clk      : IN  std_logic;
        ASYNC_IN : IN  std_logic_vector(3 downto 0);
        SYNC_OUT : OUT std_logic_vector(3 downto 0)
    );
END sync;

ARCHITECTURE BEHAVIORAL OF sync IS
    SIGNAL sreg0 : std_logic_vector(3 DOWNTO 0):="0000";
    SIGNAL sreg1 : std_logic_vector(3 DOWNTO 0):="0000";
BEGIN
    PROCESS (clk)
    BEGIN
        IF rising_edge(clk) THEN
            SYNC_OUT <= sreg1;              -- Output synchronized value
            sreg1 <= sreg0;
            sreg <= ASYNC_IN;      -- Shift register update
        END IF;
    END PROCESS;
END BEHAVIORAL;
