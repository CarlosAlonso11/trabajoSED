LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;
entity top is
    port(
        emergencia : in std_logic ;
        planta_entrada : in std_logic_vector(3 downto 0);
        clk : in std_logic ;
        puerta_sal : out std_logic ;
        motor_subir_sal : out std_logic ;
        motor_bajar_sal : out std_logic ;
        display : out std_logic_vector(6 downto 0)
        );
end top;

architecture Structural of top is
COMPONENT antirrebotes is
    PORT (
        clk : in STD_LOGIC;
        planta_in : in STD_LOGIC_VECTOR (3 downto 0);
        planta_out : out STD_LOGIC_VECTOR (3 downto 0)
    );
END COMPONENT;
COMPONENT sync is
    PORT (
        clk      : IN  std_logic;
        ASYNC_IN : IN  std_logic_vector(3 downto 0);
        SYNC_OUT : OUT std_logic_vector(3 downto 0)
    );
END COMPONENT;
COMPONENT filtro is
    PORT (
        entrada : IN std_logic_vector(3 DOWNTO 0);
        puerta : IN std_logic;
        salida : OUT std_logic_vector(3 DOWNTO 0)
    );
END COMPONENT;
COMPONENT filtro_emergencia is
    PORT (
        emergencia : IN std_logic;
        puerta_e : IN std_logic;
        motor_up_e : in std_logic;
        motor_down_e : in std_logic;
        puerta_s : out std_logic;
        motor_up_s : out std_logic;
        motor_down_s : out std_logic
    );
END COMPONENT;
COMPONENT bloqueador is
    PORT (
        entrada  : IN  std_logic_vector(3 downto 0);
        clk         : IN  std_logic;
        puerta      : IN  std_logic;
        salida_bloq : OUT  std_logic_vector(0 downto 3)
    );
END COMPONENT;
COMPONENT codif_2bits is
    PORT (
        code_4 : IN std_logic_vector(3 DOWNTO 0);
        code_2bits : OUT std_logic_vector(1 DOWNTO 0)
    );
END COMPONENT;
COMPONENT comparador is
    PORT (
        planta_act : in STD_LOGIC_VECTOR (1 downto 0);
        planta_des : in STD_LOGIC_VECTOR (1 downto 0);
        puerta : out STD_LOGIC;
        motor_subir : out STD_LOGIC;
        motor_bajar : out STD_LOGIC
    );
END COMPONENT;
COMPONENT decod_7segm is
    PORT (
        code_2bits : IN std_logic_vector(1 DOWNTO 0);
        display : OUT std_logic_vector(6 DOWNTO 0)
    );
END COMPONENT;
COMPONENT fsm is
    PORT (
        RESET      : in  std_logic;
        CLK        : in  std_logic;
        motor_up : in  std_logic;
        motor_down : in  std_logic;
        planta_actual   : out std_logic_vector(1 downto 0)
    );
END COMPONENT;
COMPONENT clock_divider is
    PORT (
        clk_in   : in  std_logic; -- Reloj de 100 MHz
        clk_out  : out std_logic  -- Señal de 1 Hz
    );
END COMPONENT;
signal antireb_sync,sync_filt,filt_bloq,bloq_cod : std_logic_vector(3 downto 0);
signal cod_comp,s_fsm : std_logic_vector(1 downto 0);
signal clk_div,igual,mayor,menor,puerta,motor_subir,motor_bajar : std_logic;
begin
Inst_antirrebotes: antirrebotes PORT MAP (
        CLK    => clk,
        planta_in => planta_entrada,
        planta_out => antireb_sync
    );

Inst_sync: sync PORT MAP (
        CLK    => clk,
        ASYNC_IN => antireb_sync,
        SYNC_OUT => sync_filt
    );

Inst_filtro: filtro PORT MAP (
        entrada    => sync_filt,
        puerta => puerta,
        salida => filt_bloq
    );
Inst_bloqueador: bloqueador PORT MAP (
        CLK    => clk,
        puerta => puerta,
        entrada => filt_bloq,
        salida_bloq => bloq_cod
    );
Inst_codif_2bits: codif_2bits PORT MAP (
        code_4    => bloq_cod,
        code_2bits => cod_comp
    );
Inst_comparador: comparador PORT MAP (
        planta_act  => s_fsm,
        planta_des => cod_comp,
        puerta => igual,
        motor_subir => mayor,
        motor_bajar => menor
    );
Inst_decod_7segm: decod_7segm PORT MAP (
        code_2bits    => s_fsm,
        display => display
    );
Inst_fsm: fsm PORT MAP (
        reset => '0',
        CLK    => clk_div,
        motor_up => motor_subir,
        motor_down => motor_bajar,
        planta_actual => s_fsm
    );
Inst_Sclock_divider: clock_divider PORT MAP (
        clk_in    => clk,
        clk_out => clk_div
    );
Inst_filtro_emergencia: filtro_emergencia PORT MAP (
        emergencia => emergencia,
        puerta_e => igual,
        motor_up_e => mayor,
        motor_down_e => menor,
        puerta_s => puerta,
        motor_up_s => motor_subir,
        motor_down_s => motor_bajar
    );
puerta_sal <= puerta ;
motor_subir_sal <= motor_subir;
motor_bajar_sal <= motor_bajar;

end Structural;
