LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY router_left IS
    PORT (
        clk, rst : IN STD_LOGIC;
        datainp1, datainp4, datainp5, datainp6, datainp9 : IN STD_LOGIC_VECTOR(12 - 1 DOWNTO 0);
        dataout1, dataout4, dataout5, dataout6, dataout9 : OUT STD_LOGIC_VECTOR(12 - 1 DOWNTO 0)
    );
END ENTITY router_left;

ARCHITECTURE RTL OF router_left IS

    COMPONENT fifo_buffer
        PORT (
            clk, rst : IN STD_LOGIC;
            write_req : IN STD_LOGIC;
            grant : IN STD_LOGIC;
            datainp : IN STD_LOGIC_VECTOR(12 - 1 DOWNTO 0);
            credit_out : OUT STD_LOGIC;
            request : OUT STD_LOGIC_VECTOR(12 - 1 DOWNTO 0);
            dataout : OUT STD_LOGIC_VECTOR(12 - 1 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT crossbar_switch_left
        PORT (
            sel1, sel4, sel5, sel6, sel9 : IN STD_LOGIC_VECTOR(3 - 1 DOWNTO 0);
            inp1, inp4, inp5, inp6, inp9 : IN STD_LOGIC_VECTOR(12 - 1 DOWNTO 0);
            out1, out4, out5, out6, out9 : OUT STD_LOGIC_VECTOR(12 - 1 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT arbiteration_left
        PORT (
            request1, request4, request5, request6, request9 : IN STD_LOGIC_VECTOR(12 - 1 DOWNTO 0);
            credit1, credit4, credit5, credit6, credit9 : IN STD_LOGIC;
            sel1, sel4, sel5, sel6, sel9 : OUT STD_LOGIC_VECTOR(3 - 1 DOWNTO 0);
            grant1, grant4, grant5, grant6, grant9 : OUT STD_LOGIC;
            write_req1, write_req4, write_req5, write_req6, write_req9 : OUT STD_LOGIC
        );
    END COMPONENT;

    SIGNAL sel1, sel4, sel5, sel6, sel9 : STD_LOGIC_VECTOR(3 - 1 DOWNTO 0);
    SIGNAL I1, I4, I5, I6, I9 : STD_LOGIC_VECTOR(12 - 1 DOWNTO 0);
    SIGNAL write_req1, write_req4, write_req5, write_req6, write_req9 : STD_LOGIC;
    SIGNAL grant1, grant4, grant5, grant6, grant9 : STD_LOGIC;
    SIGNAL req1, req4, req5, req6, req9 : STD_LOGIC_VECTOR(12 - 1 DOWNTO 0);
    SIGNAL credit1, credit4, credit5, credit6, credit9 : STD_LOGIC;

BEGIN

    F1 : fifo_buffer PORT MAP
    (
        clk => clk,
        rst => rst,
        write_req => write_req1,
        grant => grant1,
        datainp => datainp1,
        credit_out => credit1,
        request => req1,
        dataout => I1
    );

    F4 : fifo_buffer PORT MAP
    (
        clk => clk,
        rst => rst,
        write_req => write_req4,
        grant => grant4,
        datainp => datainp4,
        credit_out => credit4,
        request => req4,
        dataout => I4
    );

    F5 : fifo_buffer PORT MAP
    (
        clk => clk,
        rst => rst,
        write_req => write_req5,
        grant => grant5,
        datainp => datainp5,
        credit_out => credit5,
        request => req5,
        dataout => I5
    );

    F6 : fifo_buffer PORT MAP
    (
        clk => clk,
        rst => rst,
        write_req => write_req6,
        grant => grant6,
        datainp => datainp6,
        credit_out => credit6,
        request => req6,
        dataout => I6
    );

    F9 : fifo_buffer PORT MAP
    (
        clk => clk,
        rst => rst,
        write_req => write_req9,
        grant => grant9,
        datainp => datainp9,
        credit_out => credit9,
        request => req9,
        dataout => I9
    );

    Dcrossbar_switch_left : crossbar_switch_left PORT MAP
    (
        sel1 => sel1,
        sel4 => sel4,
        sel5 => sel5,
        sel6 => sel6,
        sel9 => sel9,
        inp1 => I1,
        inp4 => I4,
        inp5 => I5,
        inp6 => I6,
        inp9 => I9,
        out1 => dataout1,
        out4 => dataout4,
        out5 => dataout5,
        out6 => dataout6,
        out9 => dataout9
    );

    Darbiteration_left : arbiteration_left PORT MAP
    (
        request1 => req1,
        request4 => req4,
        request5 => req5,
        request6 => req6,
        request9 => req9,
        credit1 => credit1, 
        credit4 => credit4, 
        credit5 => credit5, 
        credit6 => credit6, 
        credit9 => credit9,
        sel1 => sel1, 
        sel4 => sel4, 
        sel5 => sel5, 
        sel6 => sel6, 
        sel9 => sel9,
        grant1 => grant1, 
        grant4 => grant4, 
        grant5 => grant5, 
        grant6 => grant6, 
        grant9 => grant9,
        write_req1 => write_req1, 
        write_req4 => write_req4, 
        write_req5 => write_req5, 
        write_req6 => write_req6, 
        write_req9 => write_req9
    );
END ARCHITECTURE RTL;