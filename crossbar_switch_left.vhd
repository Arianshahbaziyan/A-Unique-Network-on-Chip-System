LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY crossbar_switch_left IS
    PORT (
        sel1, sel4, sel5, sel6, sel9 : IN STD_LOGIC_VECTOR(3 - 1 DOWNTO 0);
        inp1, inp4, inp5, inp6, inp9 : IN STD_LOGIC_VECTOR(12 - 1 DOWNTO 0);
        out1, out4, out5, out6, out9 : OUT STD_LOGIC_VECTOR(12 - 1 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE BEHAV OF crossbar_switch_left IS

BEGIN
    ---------------------------------------
    mux_port1 : PROCESS (sel1, inp4, inp5, inp6, inp9)
    BEGIN
        CASE sel1 IS
            WHEN "000" =>
                out1 <= inp4;
            WHEN "001" =>
                out1 <= inp5;
            WHEN "010" =>
                out1 <= inp6;
            WHEN "011" =>
                out1 <= inp9;
            WHEN OTHERS =>
                out1 <= (others => '0');
        END CASE;
    END PROCESS mux_port1;
    ---------------------------------------
    mux_port4 : PROCESS (sel4, inp1, inp5, inp6, inp9)
    BEGIN
        CASE sel4 IS
            WHEN "000" =>
                out4 <= inp1;
            WHEN "001" =>
                out4 <= inp5;
            WHEN "010" =>
                out4 <= inp6;
            WHEN "011" =>
                out4 <= inp9;
            WHEN OTHERS =>
                out4 <= (others => '0');
        END CASE;
    END PROCESS mux_port4;
    ---------------------------------------
    mux_port5 : PROCESS (sel5, inp1, inp4, inp6, inp9)
    BEGIN
        CASE sel5 IS
            WHEN "000" =>
                out5 <= inp1;
            WHEN "001" =>
                out5 <= inp4;
            WHEN "010" =>
                out5 <= inp6;
            WHEN "011" =>
                out5 <= inp9;
            WHEN OTHERS =>
                out5 <= (others => '0');
        END CASE;
    END PROCESS mux_port5;
    ---------------------------------------
    mux_port6 : PROCESS (sel6, inp1, inp4, inp5, inp9)
    BEGIN
        CASE sel6 IS
            WHEN "000" =>
                out6 <= inp1;
            WHEN "001" =>
                out6 <= inp4;
            WHEN "010" =>
                out6 <= inp5;
            WHEN "011" =>
                out6 <= inp9;
            WHEN OTHERS =>
                out6 <= (others => '0');
        END CASE;
    END PROCESS mux_port6;
    ---------------------------------------
    mux_port9 : PROCESS (sel9, inp1, inp4, inp5, inp6)
    BEGIN
        CASE sel9 IS
            WHEN "000" =>
                out9 <= inp1;
            WHEN "001" =>
                out9 <= inp4;
            WHEN "010" =>
                out9 <= inp5;
            WHEN "011" =>
                out9 <= inp6;
            WHEN OTHERS =>
                out9 <= (others => '0');
        END CASE;
    END PROCESS mux_port9;
    ---------------------------------------
END ARCHITECTURE BEHAV;