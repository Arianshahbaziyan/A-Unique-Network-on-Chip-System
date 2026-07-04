LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY NOC IS
    PORT (
        clk, rst : IN STD_LOGIC;
        datainp1, datainp2, datainp4, datainp5, datainp6, datainp7, datainp9, datainp10 : IN STD_LOGIC_VECTOR(12 - 1 DOWNTO 0);
        dataout1, dataout2, dataout4, dataout5, dataout6, dataout7, dataout9, dataout10 : OUT STD_LOGIC_VECTOR(12 - 1 DOWNTO 0)
    );
END ENTITY NOC;

ARCHITECTURE project OF NOC IS

    COMPONENT router_left
        PORT (
            clk, rst : IN STD_LOGIC;
            datainp1, datainp4, datainp5, datainp6, datainp9 : IN STD_LOGIC_VECTOR(12 - 1 DOWNTO 0);
            dataout1, dataout4, dataout5, dataout6, dataout9 : OUT STD_LOGIC_VECTOR(12 - 1 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT router_right
        PORT (
            clk, rst : IN STD_LOGIC;
            datainp2, datainp7, datainp5, datainp6, datainp10 : IN STD_LOGIC_VECTOR(12 - 1 DOWNTO 0);
            dataout2, dataout7, dataout5, dataout6, dataout10 : OUT STD_LOGIC_VECTOR(12 - 1 DOWNTO 0)
        );
    END COMPONENT;

    SIGNAL six_five, five_six : STD_LOGIC_VECTOR(12 - 1 DOWNTO 0);

BEGIN

    left : router_left PORT MAP
    (
        clk => clk,
        rst => rst,
        datainp1 => datainp1,
        datainp4 => datainp4,
        datainp5 => datainp5,
        datainp6 => six_five,
        datainp9 => datainp9,
        dataout1 => dataout1,
        dataout4 => dataout4,
        dataout5 => dataout5,
        dataout6 => five_six,
        dataout9 => dataout9
    );

    right : router_right PORT MAP
    (
        clk => clk,
        rst => rst,
        datainp2 => datainp2,
        datainp7 => datainp7,
        datainp5 => five_six,
        datainp6 => datainp6,
        datainp10 => datainp10,
        dataout2 => dataout2,
        dataout7 => dataout7,
        dataout5 => six_five,
        dataout6 => dataout6,
        dataout10 => dataout10
    );
END ARCHITECTURE project;