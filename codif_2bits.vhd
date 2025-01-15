LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY codif_2bits IS
PORT (
    code_4 : IN std_logic_vector(3 DOWNTO 0);
    code_2bits : OUT std_logic_vector(1 DOWNTO 0)
);
END ENTITY codif_2bits;

ARCHITECTURE dataflow OF codif_2bits IS
BEGIN
WITH code_4 SELECT
    code_2bits <= "00" WHEN "0001",
                  "01" WHEN "0010",
                  "10" WHEN "0100",
                  "11" WHEN "1000",
                  "00" WHEN OTHERS;  
END ARCHITECTURE dataflow;
