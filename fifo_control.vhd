LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY fifo_control IS
    PORT (
        clk, rst : IN STD_LOGIC;
        grant : IN STD_LOGIC;
        datainp : IN STD_LOGIC_VECTOR(12 - 1 DOWNTO 0);
        write_req : IN STD_LOGIC;
        w_address : OUT STD_LOGIC_VECTOR(4 - 1 DOWNTO 0);
        r_address : OUT STD_LOGIC_VECTOR(4 - 1 DOWNTO 0);
        credit_out : OUT STD_LOGIC
    );
END ENTITY fifo_control;

ARCHITECTURE BEHAV OF fifo_control IS
    SIGNAL RregW, RregR : unsigned(4 - 1 DOWNTO 0);
    SIGNAL RnxtW, RnxtR : unsigned(4 - 1 DOWNTO 0);
    SIGNAL ful : STD_LOGIC;
    SIGNAL empt : STD_LOGIC;
BEGIN
    main : PROCESS (clk, rst)
    BEGIN
        IF rst = '1' THEN
            RregW <= "0000";
            RregR <= "0000";
        ELSIF clk'event AND clk = '1' THEN
            RregW <= RnxtW;
            RregR <= RnxtR;
        END IF;
    END PROCESS main;
    -------------------------------------------------------
    Wpointer : PROCESS (RregW, write_req, ful, empt, datainp)
    BEGIN
        RnxtW <= RregW;
        IF ful = '0' THEN
            IF write_req = '1' AND RregW <= "1111" AND datainp /= "UUUUUUUUUUUU" AND datainp /= "000000000000" THEN
                RnxtW <= RregW + 1;
            END IF;
        ELSIF ful = '1' AND empt = '1' THEN
            RnxtW <= "0000";
        END IF;
    END PROCESS Wpointer;
    -------------------------------------------------------
    Rpointer : PROCESS (RregR, grant, empt, ful)
    BEGIN
        RnxtR <= RregR;
        IF empt = '0' THEN
            IF grant = '1' AND RregR <= "1111" THEN
                RnxtR <= RregR + 1;
            END IF;
        ELSIF ful = '1' AND empt = '1' THEN
            RnxtR <= "0000";
        END IF;
    END PROCESS Rpointer;
    -------------------------------------------------------
    Ful <= '1' WHEN RregW = "1111" ELSE
        '0';
    empt <= '1' WHEN RregR >= RregW ELSE
        '0';
    -------------------------------------------------------
    w_address <= STD_LOGIC_VECTOR(RregW);
    r_address <= STD_LOGIC_VECTOR(RregR);
    credit_out <= ful;
END ARCHITECTURE BEHAV;