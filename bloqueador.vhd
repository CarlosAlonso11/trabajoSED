library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity bloqueador is
    PORT (
        entrada  : IN  std_logic_vector(3 downto 0);
        clk         : IN  std_logic;
        puerta      : IN  std_logic;
        salida_bloq : OUT  std_logic_vector(0 downto 3)
    );

end bloqueador;

 architecture structural of bloqueador is

COMPONENT flip_flop_jk is
    PORT (
        J      : IN  std_logic;
        K        : IN  std_logic;
        clk : IN  std_logic;
        Q : OUT std_logic
    );
END COMPONENT;

begin

Inst_jk0: flip_flop_jk PORT MAP (
        J      => entrada(0),
        CLK         => clk,
        K  => puerta,
        Q    => salida_bloq(0)
    );

Inst_jk1: flip_flop_jk PORT MAP (
        J      => entrada(1),
        CLK         => clk,
        K  => puerta,
        Q    => salida_bloq(1)
    );

Inst_jk2: flip_flop_jk PORT MAP (
        J      => entrada(2),
        CLK         => clk,
        K  => puerta,
        Q    => salida_bloq(2)
    );

Inst_jk3: flip_flop_jk PORT MAP (
        J      => entrada(3),
        CLK         => clk,
        K  => puerta,
        Q    => salida_bloq(3)
    );

end structural;
