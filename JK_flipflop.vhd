library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity flip_flop_jk is
    Port (
        clk   : in  std_logic; -- Reloj
        J     : in  std_logic; -- Entrada J
        K     : in  std_logic; -- Entrada K
        Q     : out std_logic  -- Salida Q
    );
end flip_flop_jk;

architecture Behavioral of flip_flop_jk is
    signal Q_internal : std_logic := '0'; -- Señal interna para la salida
    signal jk : std_logic_vector(0 to 1);
begin
    jk(0) <= J;
    jk(1) <= K;
    process(clk)
    begin
        if rising_edge(clk) then
          case (jk) is
              when "00" => 
                  Q_internal <= Q_internal; -- No cambia
              when "01" => 
                  Q_internal <= '0'; -- Reseteo
              when "10" => 
                  Q_internal <= '1'; -- Seteo
              when "11" => 
                  Q_internal <= not Q_internal; -- Toggle
              when others => 
                  Q_internal <= Q_internal; -- No cambia
            end case;
        end if;
    end process;

    Q <= Q_internal; -- Asignar la señal interna a la salida

end Behavioral;
