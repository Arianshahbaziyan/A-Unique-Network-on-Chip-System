LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY arbiter_right IS
    PORT (
        credit2, credit7, credit5, credit6, credit10 : IN STD_LOGIC;
        SIGNAL request2, request7, request5, request6, request10 : STD_LOGIC_VECTOR(12 - 1 DOWNTO 0);
        selector2, selector7, selector5, selector6, selector10 : IN STD_LOGIC_VECTOR(3 - 1 DOWNTO 0);
        grant : IN STD_LOGIC_VECTOR(5 - 1 DOWNTO 0);
        ------------------------------------------------------
        sel2, sel7, sel5, sel6, sel10 : OUT STD_LOGIC_VECTOR(3 - 1 DOWNTO 0);
        grant2, grant7, grant5, grant6, grant10 : OUT STD_LOGIC;
        write_req2, write_req7, write_req5, write_req6, write_req10 : OUT STD_LOGIC;
        request_tg2, request_tg7, request_tg5, request_tg6, request_tg10 : OUT STD_LOGIC_VECTOR(12 - 1 DOWNTO 0);
        request_ro2, request_ro7, request_ro5, request_ro6, request_ro10 : OUT STD_LOGIC_VECTOR(12 - 1 DOWNTO 0)
    );
END ENTITY arbiter_right;

ARCHITECTURE BEHAV OF arbiter_right IS

BEGIN
    request_tg2 <= request2;
    request_tg5 <= request5;
    request_tg6 <= request6;
    request_tg7 <= request7;
    request_tg10 <= request10;
    ---
    request_ro2 <= request2;
    request_ro5 <= request5;
    request_ro6 <= request6;
    request_ro7 <= request7;
    request_ro10 <= request10;
    ---
    grant2 <= grant(0);
    grant5 <= grant(1);
    grant6 <= grant(2);
    grant7 <= grant(3);
    grant10 <= grant(4);
    ---
    sel2 <= selector2;
    sel5 <= selector5;
    sel6 <= selector6;
    sel7 <= selector7;
    sel10 <= selector10;
    --
    write_req2 <= '1' WHEN credit2 = '0' ELSE
        '0';
    write_req5 <= '1' WHEN credit5 = '0' ELSE
        '0';
    write_req6 <= '1' WHEN credit6 = '0' ELSE
        '0';
    write_req7 <= '1' WHEN credit7 = '0' ELSE
        '0';
    write_req10 <= '1' WHEN credit10 = '0' ELSE
        '0';

END ARCHITECTURE BEHAV;