LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY router_right IS
    PORT (
        clk, rst : IN STD_LOGIC;
        datainp2, datainp7, datainp5, datainp6, datainp10 : IN STD_LOGIC_VECTOR(12 - 1 DOWNTO 0);
        dataout2, dataout7, dataout5, dataout6, dataout10 : OUT STD_LOGIC_VECTOR(12 - 1 DOWNTO 0)
    );
END ENTITY router_right;

ARCHITECTURE RTL OF router_right IS

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

    COMPONENT crossbar_switch_right
        PORT (
            sel2, sel7, sel5, sel6, sel10 : IN STD_LOGIC_VECTOR(3 - 1 DOWNTO 0);
            inp2, inp7, inp5, inp6, inp10 : IN STD_LOGIC_VECTOR(12 - 1 DOWNTO 0);
            out2, out7, out5, out6, out10 : OUT STD_LOGIC_VECTOR(12 - 1 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT arbiteration_right
        PORT (
            request2, request7, request5, request6, request10 : IN STD_LOGIC_VECTOR(12 - 1 DOWNTO 0);
            credit2, credit7, credit5, credit6, credit10 : IN STD_LOGIC;
            sel2, sel7, sel5, sel6, sel10 : OUT STD_LOGIC_VECTOR(3 - 1 DOWNTO 0);
            grant2, grant7, grant5, grant6, grant10 : OUT STD_LOGIC;
            write_req2, write_req7, write_req5, write_req6, write_req10 : OUT STD_LOGIC
        );
    END COMPONENT;

    SIGNAL sel2, sel7, sel5, sel6, sel10 : STD_LOGIC_VECTOR(3 - 1 DOWNTO 0);
    SIGNAL I2, I7, I5, I6, I10 : STD_LOGIC_VECTOR(12 - 1 DOWNTO 0);
    SIGNAL write_req2, write_req7, write_req5, write_req6, write_req10 : STD_LOGIC;
    SIGNAL grant2, grant7, grant5, grant6, grant10 : STD_LOGIC;
    SIGNAL req2, req7, req5, req6, req10 : STD_LOGIC_VECTOR(12 - 1 DOWNTO 0);
    SIGNAL credit2, credit7, credit5, credit6, credit10 : STD_LOGIC;

BEGIN

    F2 : fifo_buffer PORT MAP
    (
        clk => clk,
        rst => rst,
        write_req => write_req2,
        grant => grant2,
        datainp => datainp2,
        credit_out => credit2,
        request => req2,
        dataout => I2
    );

    F7 : fifo_buffer PORT MAP
    (
        clk => clk,
        rst => rst,
        write_req => write_req7,
        grant => grant7,
        datainp => datainp7,
        credit_out => credit7,
        request => req7,
        dataout => I7
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

    F10 : fifo_buffer PORT MAP
    (
        clk => clk,
        rst => rst,
        write_req => write_req10,
        grant => grant10,
        datainp => datainp10,
        credit_out => credit10,
        request => req10,
        dataout => I10
    );

    Dcrossbar_switch_right : crossbar_switch_right PORT MAP
    (
        sel2 => sel2,
        sel7 => sel7,
        sel5 => sel5,
        sel6 => sel6,
        sel10 => sel10,
        inp2 => I2,
        inp7 => I7,
        inp5 => I5,
        inp6 => I6,
        inp10 => I10,
        out2 => dataout2,
        out7 => dataout7,
        out5 => dataout5,
        out6 => dataout6,
        out10 => dataout10
    );

    Darbiteration_right : arbiteration_right PORT MAP
    (
        request2 => req2,
        request7 => req7,
        request5 => req5,
        request6 => req6,
        request10 => req10,
        credit2 => credit2, 
        credit7 => credit7, 
        credit5 => credit5, 
        credit6 => credit6, 
        credit10 => credit10,
        sel2 => sel2, 
        sel7 => sel7, 
        sel5 => sel5, 
        sel6 => sel6, 
        sel10 => sel10,
        grant2 => grant2, 
        grant7 => grant7, 
        grant5 => grant5, 
        grant6 => grant6, 
        grant10 => grant10,
        write_req2 => write_req2, 
        write_req7 => write_req7, 
        write_req5 => write_req5, 
        write_req6 => write_req6, 
        write_req10 => write_req10
    );
END ARCHITECTURE RTL;