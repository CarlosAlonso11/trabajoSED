library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;


entity antirrebotes is
    Port ( clk : in STD_LOGIC;
           planta_in : in STD_LOGIC_VECTOR (3 downto 0);
           planta_out : out STD_LOGIC_VECTOR (3 downto 0));
end antirrebotes;

architecture Behavioral of antirrebotes is
 type debounce_cnt_type is array(0 to 3) of unsigned(7 downto 0);
    signal debounce_cnt : debounce_cnt_type := (others => (others => '0'));
    signal planta_sync  : std_logic_vector(3 downto 0) := (others => '0');  
    signal planta_stable: std_logic_vector(3 downto 0) := (others => '0');  
begin

    process(clk)
    begin
        if rising_edge(clk) then
            -- Recorrer las 4 plantas
            for i in 0 to 3 loop
                -- Sincronización doble
                planta_sync(i) <= planta_in(i);

                -- Si la planta no cambia, resetear el contador
                if planta_sync(i) = planta_stable(i) then
                    debounce_cnt(i) <= (others => '0'); 
                else
                    -- Incrementar contador si hay cambio
                    debounce_cnt(i) <= debounce_cnt(i) + 1; 
                    -- Si el contador alcanza el máximo, actualizar el estado estable
                    if debounce_cnt(i) = "11111111" then
                        planta_stable(i) <= planta_sync(i);
                    end if;
                end if;
            end loop;
        end if;
    end process;

    -- Asignar las señales filtradas a la salida
    planta_out <= planta_stable;

end Behavioral;
