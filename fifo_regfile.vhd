LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY fifo_regfile IS
    PORT (
        clk, rst : IN STD_LOGIC;
        write_enb : IN STD_LOGIC;
        read_enb : IN STD_LOGIC;
        w_address : IN STD_LOGIC_VECTOR(4 - 1 DOWNTO 0);
        r_address : IN STD_LOGIC_VECTOR(4 - 1 DOWNTO 0);
        datainp : IN STD_LOGIC_VECTOR(12 - 1 DOWNTO 0);
        request : OUT STD_LOGIC_VECTOR(12 - 1 DOWNTO 0);
        dataout : OUT STD_LOGIC_VECTOR(12 - 1 DOWNTO 0)
    );
END ENTITY fifo_regfile;

ARCHITECTURE BEHAV OF fifo_regfile IS
    -------------------------------------------------------
    TYPE register_15_slots IS ARRAY(15 - 1 DOWNTO 0) OF STD_LOGIC_VECTOR(12 - 1 DOWNTO 0);
    SIGNAL Rreg : register_15_slots;
    SIGNAL Rnxt : register_15_slots;
    -------------------------------------------------------
BEGIN
    -------------------------------------------------------
    reg : PROCESS (clk, rst)
    BEGIN
        IF rst = '1' THEN
            Rreg <= (OTHERS => (OTHERS => '0'));
        ELSIF clk'event AND clk = '1' THEN
            Rreg <= Rnxt;
        END IF;
    END PROCESS reg;
    -------------------------------------------------------
    writing : PROCESS (Rreg, w_address, write_enb, datainp)
    BEGIN
        Rnxt <= Rreg;
        IF write_enb = '1' and datainp /= "UUUUUUUUUUUU" THEN
            Rnxt(to_integer(unsigned(w_address))) <= datainp;
        END IF;
    END PROCESS writing;
    -------------------------------------------------------

    dataout <=
        Rreg(to_integer(unsigned(R_address))) WHEN read_enb = '1' ELSE
        (OTHERS => '0');
    -----
    request <= Rreg(to_integer(unsigned(R_address)));

END ARCHITECTURE BEHAV;