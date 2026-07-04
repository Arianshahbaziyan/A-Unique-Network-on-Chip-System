LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY arbiter_left IS
    PORT (
        credit1, credit4, credit5, credit6, credit9 : IN STD_LOGIC;
        SIGNAL request1, request4, request5, request6, request9 : STD_LOGIC_VECTOR(12 - 1 DOWNTO 0);
        selector1, selector4, selector5, selector6, selector9 : IN STD_LOGIC_VECTOR(3 - 1 DOWNTO 0);
        grant : IN STD_LOGIC_VECTOR(5 - 1 DOWNTO 0);
        ------------------------------------------------------
        sel1, sel4, sel5, sel6, sel9 : OUT STD_LOGIC_VECTOR(3 - 1 DOWNTO 0);
        grant1, grant4, grant5, grant6, grant9 : OUT STD_LOGIC;
        write_req1, write_req4, write_req5, write_req6, write_req9 : OUT STD_LOGIC;
        request_tg1, request_tg4, request_tg5, request_tg6, request_tg9 : OUT STD_LOGIC_VECTOR(12 - 1 DOWNTO 0);
        request_ro1, request_ro4, request_ro5, request_ro6, request_ro9 : OUT STD_LOGIC_VECTOR(12 - 1 DOWNTO 0)
    );
END ENTITY arbiter_left;

ARCHITECTURE BEHAV OF arbiter_left IS

BEGIN
    request_tg1 <= request1;
    request_tg4 <= request4;
    request_tg5 <= request5;
    request_tg6 <= request6;
    request_tg9 <= request9;
    ---
    request_ro1 <= request1;
    request_ro4 <= request4;
    request_ro5 <= request5;
    request_ro6 <= request6;
    request_ro9 <= request9;
    ---
    grant1 <= grant(0);
    grant4 <= grant(1);
    grant5 <= grant(2);
    grant6 <= grant(3);
    grant9 <= grant(4);
    ---
    sel1 <= selector1;
    sel4 <= selector4;
    sel5 <= selector5;
    sel6 <= selector6;
    sel9 <= selector9;
    --
    write_req1 <= '1' WHEN credit1 = '0' ELSE
        '0';
    write_req4 <= '1' WHEN credit4 = '0' ELSE
        '0';
    write_req5 <= '1' WHEN credit5 = '0' ELSE
        '0';
    write_req6 <= '1' WHEN credit6 = '0' ELSE
        '0';
    write_req9 <= '1' WHEN credit9 = '0' ELSE
        '0';

END ARCHITECTURE BEHAV;