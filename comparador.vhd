library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
entity comparador is
    Port ( planta_act : in STD_LOGIC_VECTOR (1 downto 0);
           planta_des : in STD_LOGIC_VECTOR (1 downto 0);
           puerta : out STD_LOGIC;
           motor_subir : out STD_LOGIC;
           motor_bajar : out STD_LOGIC);
end comparador;

architecture Behavioral of comparador is

 signal plant_act_int, plant_des_int : integer;
begin
    plant_act_int <= to_integer(unsigned(plant_act));
    plant_des_int <= to_integer(unsigned(plant_des));

    process (plant_act_int, plant_des_int)
    begin
        -- Comparación entre plantas
        if plant_act_int = plant_des_int then
            puerta <= '1';
            motor_subir <= '0';
            motor_bajar <= '0';

        elsif plant_act_int < plant_des_int then
            puerta <= '0';
            motor_subir <= '1';
            motor_bajar <= '0';

        else
            puerta <= '0';
            motor_subir <= '0';
            motor_bajar <= '1';
        end if;
    end process;

end Behavioral;
