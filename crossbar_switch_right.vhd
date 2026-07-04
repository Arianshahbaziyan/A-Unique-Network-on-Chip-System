LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY crossbar_switch_right IS
    PORT (
        sel2, sel7, sel5, sel6, sel10 : IN STD_LOGIC_VECTOR(3 - 1 DOWNTO 0);
        inp2, inp7, inp5, inp6, inp10 : IN STD_LOGIC_VECTOR(12 - 1 DOWNTO 0);
        out2, out7, out5, out6, out10 : OUT STD_LOGIC_VECTOR(12 - 1 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE BEHAV OF crossbar_switch_right IS

BEGIN
    ---------------------------------------
    mux_port2 : PROCESS (sel2, inp7, inp5, inp6, inp10)
    BEGIN
        CASE sel2 IS
            WHEN "000" =>
                out2 <= inp5;
            WHEN "001" =>
                out2 <= inp6;
            WHEN "010" =>
                out2 <= inp7;
            WHEN "011" =>
                out2 <= inp10;
            WHEN OTHERS =>
                out2 <= (others => '0');
        END CASE;
    END PROCESS mux_port2;
    ---------------------------------------
    mux_port5 : PROCESS (sel5, inp2, inp7, inp6, inp10)
    BEGIN
        CASE sel5 IS
            WHEN "000" =>
                out5 <= inp2;
            WHEN "001" =>
                out5 <= inp6;
            WHEN "010" =>
                out5 <= inp7;
            WHEN "011" =>
                out5 <= inp10;
            WHEN OTHERS =>
                out5 <= (others => '0');
        END CASE;
    END PROCESS mux_port5;
    ---------------------------------------
    mux_port7 : PROCESS (sel7, inp2, inp5, inp6, inp10)
    BEGIN
        CASE sel7 IS
            WHEN "000" =>
                out7 <= inp2;
            WHEN "001" =>
                out7 <= inp5;
            WHEN "010" =>
                out7 <= inp6;
            WHEN "011" =>
                out7 <= inp10;
            WHEN OTHERS =>
                out7 <= (others => '0');
        END CASE;
    END PROCESS mux_port7;
    ---------------------------------------
    mux_port6 : PROCESS (sel6, inp2, inp5, inp7, inp10)
    BEGIN
        CASE sel6 IS
            WHEN "000" =>
                out6 <= inp2;
            WHEN "001" =>
                out6 <= inp5;
            WHEN "010" =>
                out6 <= inp7;
            WHEN "011" =>
                out6 <= inp10;
            WHEN OTHERS =>
                out6 <= (others => '0');
        END CASE;
    END PROCESS mux_port6;
    ---------------------------------------
    mux_port10 : PROCESS (sel10, inp2, inp7, inp5, inp6)
    BEGIN
        CASE sel10 IS
            WHEN "000" =>
                out10 <= inp2;
            WHEN "001" =>
                out10 <= inp5;
            WHEN "010" =>
                out10 <= inp6;
            WHEN "011" =>
                out10 <= inp7;
            WHEN OTHERS =>
                out10 <= (others => '0');
        END CASE;
    END PROCESS mux_port10;
    ---------------------------------------
END ARCHITECTURE BEHAV;