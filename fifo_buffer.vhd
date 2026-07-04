LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY fifo_buffer IS
    PORT (
        clk, rst : IN STD_LOGIC;
        write_req : IN STD_LOGIC;
        grant : IN STD_LOGIC;
        datainp : IN STD_LOGIC_VECTOR(12 - 1 DOWNTO 0);
        credit_out : OUT STD_LOGIC;
        request : OUT STD_LOGIC_VECTOR(12 - 1 DOWNTO 0);
        dataout : OUT STD_LOGIC_VECTOR(12 - 1 DOWNTO 0)
    );
END ENTITY fifo_buffer;

ARCHITECTURE RTL OF fifo_buffer IS

    COMPONENT fifo_control
        PORT (
            clk, rst : IN STD_LOGIC;
            grant : IN STD_LOGIC;
            datainp : IN STD_LOGIC_VECTOR(12 - 1 DOWNTO 0);
            write_req : IN STD_LOGIC;
            w_address : OUT STD_LOGIC_VECTOR(4 - 1 DOWNTO 0);
            r_address : OUT STD_LOGIC_VECTOR(4 - 1 DOWNTO 0);
            credit_out : OUT STD_LOGIC
        );
    END COMPONENT;

    COMPONENT fifo_regfile
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
    END COMPONENT;

    SIGNAL write_enb, full : STD_LOGIC;
    SIGNAL read_enb : STD_LOGIC;
    SIGNAL w_address : STD_LOGIC_VECTOR(4 - 1 DOWNTO 0);
    SIGNAL r_address : STD_LOGIC_VECTOR(4 - 1 DOWNTO 0);
    SIGNAL req_out : STD_LOGIC_VECTOR(12 - 1 DOWNTO 0);

BEGIN

    Dfifo_control : fifo_control PORT MAP
    (
        clk => clk,
        rst => rst,
        grant => grant,
        datainp => datainp,
        write_req => write_req,
        w_address => w_address,
        r_address => r_address,
        credit_out => full

    );

    Dfifo_regfile : fifo_regfile PORT MAP
    (
        clk => clk,
        rst => rst,
        write_enb => write_enb,
        read_enb => read_enb,
        w_address => w_address,
        r_address => r_address,
        datainp => datainp,
        request => req_out,
        dataout => dataout
    );
    credit_out <= full;
    write_enb <= write_req AND (NOT(full));
    read_enb <= grant;
    request <= req_out;

END ARCHITECTURE RTL;