LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;
ENTITY filtro_emergencia IS
PORT (
emergencia : IN std_logic;
puerta_e : IN std_logic;
motor_up_e : in std_logic;
motor_down_e : in std_logic;
puerta_s : out std_logic;
motor_up_s : out std_logic;
motor_down_s : out std_logic
);
END ENTITY filtro_emergencia;
ARCHITECTURE dataflow OF filtro_emergencia IS
BEGIN
    puerta_s <= puerta_e when emergencia='0' else '0';
    motor_up_s <= motor_up_e when emergencia='0' else '0';
    motor_down_s <= motor_down_e when emergencia='0' else '0';
END ARCHITECTURE dataflow;