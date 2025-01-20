library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity fsm is
    port (
        RESET      : in  std_logic;
        CLK        : in  std_logic;
        motor_up : in  std_logic;
        motor_down : in  std_logic;
        planta_actual   : out std_logic_vector(1 downto 0)
    );
end fsm;

architecture behavioral of fsm is
    type STATES is (S0, S1, S2, S3);
    signal current_state: STATES := S0;
    signal next_state: STATES;
    signal motordir_ud :  std_logic_vector(0 to 1); --primer bit es arriba segundo abajo
begin
    motordir_ud(0) <= motor_up;
    motordir_ud(1) <= motor_down;
    state_register: process (RESET, CLK)
    begin
       if RESET = '1' then
            current_state <= S0;
       elsif rising_edge(CLK) then
            current_state <=next_state;
       end if;
    end process;

    nextstate_decod: process (motordir_ud, current_state)
    begin
        next_state <= current_state;
        case current_state is
            when S0 =>
                if motordir_ud = "10" then
                    next_state <= S1;
                end if;

            when S1 =>
                if motordir_ud = "10" then
                    next_state <= S2;
                elsif motordir_ud = "01" then
                    next_state <= S1;
                end if;

            when S2 =>
                if motordir_ud = "10" then
                    next_state <= S3;
                elsif motordir_ud = "01" then
                    next_state <= S2;
                end if;

            when S3 =>
                if motordir_ud = "01" then
                    next_state <= S2;
                end if;
        end case;
    end process;

    output_decod: process (current_state)
    begin
        planta_actual <= (OTHERS => '0');
        case current_state is
            when S0 =>
                planta_actual <= "00";

            when S1 =>
                planta_actual <= "01";

            when S2 =>
                planta_actual <= "10";

            when S3 =>
                planta_actual <= "11";
        end case;
    end process;
end behavioral;