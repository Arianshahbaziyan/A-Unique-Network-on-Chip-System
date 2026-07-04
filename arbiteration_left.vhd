LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY arbiteration_left IS
    PORT (
        request1, request4, request5, request6, request9 : IN STD_LOGIC_VECTOR(12 - 1 DOWNTO 0);
        credit1, credit4, credit5, credit6, credit9 : IN STD_LOGIC;
        sel1, sel4, sel5, sel6, sel9 : OUT STD_LOGIC_VECTOR(3 - 1 DOWNTO 0);
        grant1, grant4, grant5, grant6, grant9 : OUT STD_LOGIC;
        write_req1, write_req4, write_req5, write_req6, write_req9 : OUT STD_LOGIC
    );
END ENTITY arbiteration_left;

ARCHITECTURE RTL OF arbiteration_left IS
    ---------------------------------------
    COMPONENT arbiter_left
        PORT (

            credit1, credit4, credit5, credit6, credit9 : IN STD_LOGIC;
            request1, request4, request5, request6, request9 : IN STD_LOGIC_VECTOR(12 - 1 DOWNTO 0);
            selector1, selector4, selector5, selector6, selector9 : IN STD_LOGIC_VECTOR(3 - 1 DOWNTO 0);
            grant : IN STD_LOGIC_VECTOR(5 - 1 DOWNTO 0);

            sel1, sel4, sel5, sel6, sel9 : OUT STD_LOGIC_VECTOR(3 - 1 DOWNTO 0);
            grant1, grant4, grant5, grant6, grant9 : OUT STD_LOGIC;
            write_req1, write_req4, write_req5, write_req6, write_req9 : OUT STD_LOGIC;
            request_tg1, request_tg4, request_tg5, request_tg6, request_tg9 : OUT STD_LOGIC_VECTOR(12 - 1 DOWNTO 0);
            request_ro1, request_ro4, request_ro5, request_ro6, request_ro9 : OUT STD_LOGIC_VECTOR(12 - 1 DOWNTO 0)
        );
    END COMPONENT arbiter_left;
    ---------------------------------------
    COMPONENT tagger_left
        PORT (
            request1, request4, request5, request6, request9 : IN STD_LOGIC_VECTOR(12 - 1 DOWNTO 0);
            grant : OUT STD_LOGIC_VECTOR(5 - 1 DOWNTO 0)
        );
    END COMPONENT tagger_left;
    ---------------------------------------
    COMPONENT routing_unit_left
        PORT (
            request1, request4, request5, request6, request9 : IN STD_LOGIC_VECTOR(12 - 1 DOWNTO 0);
            selector1, selector4, selector5, selector6, selector9 : OUT STD_LOGIC_VECTOR(3 - 1 DOWNTO 0)
        );
    END COMPONENT routing_unit_left;

    SIGNAL req_tg1, req_tg4, req_tg5, req_tg6, req_tg9 : STD_LOGIC_VECTOR(12 - 1 DOWNTO 0);
    SIGNAL req_ro1, req_ro4, req_ro5, req_ro6, req_ro9 : STD_LOGIC_VECTOR(12 - 1 DOWNTO 0);
    SIGNAL select1, select4, select5, select6, select9 : STD_LOGIC_VECTOR(3 - 1 DOWNTO 0);
    SIGNAL grant : STD_LOGIC_VECTOR(5 - 1 DOWNTO 0);
BEGIN

    Darbiter_left : arbiter_left PORT MAP
    (
        credit1 => credit1,
        credit4 => credit4,
        credit5 => credit5,
        credit6 => credit6,
        credit9 => credit9,
        request1 => request1,
        request4 => request4,
        request5 => request5,
        request6 => request6,
        request9 => request9,
        selector1 => select1,
        selector4 => select4,
        selector5 => select5,
        selector6 => select6,
        selector9 => select9,
        grant => grant,
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
        write_req9 => write_req9,
        request_tg1 => req_tg1,
        request_tg4 => req_tg4,
        request_tg5 => req_tg5,
        request_tg6 => req_tg6,
        request_tg9 => req_tg9,
        request_ro1 => req_ro1,
        request_ro4 => req_ro4,
        request_ro5 => req_ro5,
        request_ro6 => req_ro6,
        request_ro9 => req_ro9

    );

    Dtagger_left : tagger_left PORT MAP
    (
        request1 => req_tg1,
        request4 => req_tg4,
        request5 => req_tg5,
        request6 => req_tg6,
        request9 => req_tg9,
        grant => grant
    );

    Drouting_unit_left : routing_unit_left PORT MAP
    (
        request1 => req_ro1,
        request4 => req_ro4,
        request5 => req_ro5,
        request6 => req_ro6,
        request9 => req_ro9,
        selector1 => select1,
        selector4 => select4,
        selector5 => select5,
        selector6 => select6,
        selector9 => select9
    );
END RTL;