LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;
ENTITY filtro IS
PORT (
entrada : IN std_logic_vector(3 DOWNTO 0);
puerta : IN std_logic;
salida : OUT std_logic_vector(3 DOWNTO 0)
);
END ENTITY filtro;
ARCHITECTURE dataflow OF filtro IS
BEGIN
    salida <= entrada when puerta='1' else
     "0000";
END ARCHITECTURE dataflow;