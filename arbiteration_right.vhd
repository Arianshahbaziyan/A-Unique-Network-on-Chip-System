LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY arbiteration_right IS
    PORT (
        request2, request7, request5, request6, request10 : IN STD_LOGIC_VECTOR(12 - 1 DOWNTO 0);
        credit2, credit7, credit5, credit6, credit10 : IN STD_LOGIC;
        sel2, sel7, sel5, sel6, sel10 : OUT STD_LOGIC_VECTOR(3 - 1 DOWNTO 0);
        grant2, grant7, grant5, grant6, grant10 : OUT STD_LOGIC;
        write_req2, write_req7, write_req5, write_req6, write_req10 : OUT STD_LOGIC
    );
END ENTITY arbiteration_right;

ARCHITECTURE RTL OF arbiteration_right IS
    ---------------------------------------
    COMPONENT arbiter_right
        PORT (

            credit2, credit7, credit5, credit6, credit10 : IN STD_LOGIC;
            request2, request7, request5, request6, request10 : IN STD_LOGIC_VECTOR(12 - 1 DOWNTO 0);
            selector2, selector7, selector5, selector6, selector10 : IN STD_LOGIC_VECTOR(3 - 1 DOWNTO 0);
            grant : IN STD_LOGIC_VECTOR(5 - 1 DOWNTO 0);

            sel2, sel7, sel5, sel6, sel10 : OUT STD_LOGIC_VECTOR(3 - 1 DOWNTO 0);
            grant2, grant7, grant5, grant6, grant10 : OUT STD_LOGIC;
            write_req2, write_req7, write_req5, write_req6, write_req10 : OUT STD_LOGIC;
            request_tg2, request_tg7, request_tg5, request_tg6, request_tg10 : OUT STD_LOGIC_VECTOR(12 - 1 DOWNTO 0);
            request_ro2, request_ro7, request_ro5, request_ro6, request_ro10 : OUT STD_LOGIC_VECTOR(12 - 1 DOWNTO 0)
        );
    END COMPONENT arbiter_right;
    ---------------------------------------
    COMPONENT tagger_right
        PORT (
            request2, request7, request5, request6, request10 : IN STD_LOGIC_VECTOR(12 - 1 DOWNTO 0);
            grant : OUT STD_LOGIC_VECTOR(5 - 1 DOWNTO 0)
        );
    END COMPONENT tagger_right;
    ---------------------------------------
    COMPONENT routing_unit_right
        PORT (
            request2, request7, request5, request6, request10 : IN STD_LOGIC_VECTOR(12 - 1 DOWNTO 0);
            selector2, selector7, selector5, selector6, selector10 : OUT STD_LOGIC_VECTOR(3 - 1 DOWNTO 0)
        );
    END COMPONENT routing_unit_right;

    SIGNAL req_tg2, req_tg7, req_tg5, req_tg6, req_tg10 : STD_LOGIC_VECTOR(12 - 1 DOWNTO 0);
    SIGNAL req_ro2, req_ro7, req_ro5, req_ro6, req_ro10 : STD_LOGIC_VECTOR(12 - 1 DOWNTO 0);
    SIGNAL select2, select7, select5, select6, select10 : STD_LOGIC_VECTOR(3 - 1 DOWNTO 0);
    SIGNAL grant : STD_LOGIC_VECTOR(5 - 1 DOWNTO 0);
BEGIN

    Darbiter_right : arbiter_right PORT MAP
    (
        credit2 => credit2,
        credit7 => credit7,
        credit5 => credit5,
        credit6 => credit6,
        credit10 => credit10,
        request2 => request2,
        request7 => request7,
        request5 => request5,
        request6 => request6,
        request10 => request10,
        selector2 => select2,
        selector7 => select7,
        selector5 => select5,
        selector6 => select6,
        selector10 => select10,
        grant => grant,
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
        write_req10 => write_req10,
        request_tg2 => req_tg2,
        request_tg7 => req_tg7,
        request_tg5 => req_tg5,
        request_tg6 => req_tg6,
        request_tg10 => req_tg10,
        request_ro2 => req_ro2,
        request_ro7 => req_ro7,
        request_ro5 => req_ro5,
        request_ro6 => req_ro6,
        request_ro10 => req_ro10

    );

    Dtagger_right : tagger_right PORT MAP
    (
        request2 => req_tg2,
        request7 => req_tg7,
        request5 => req_tg5,
        request6 => req_tg6,
        request10 => req_tg10,
        grant => grant
    );

    Drouting_unit_right : routing_unit_right PORT MAP
    (
        request2 => req_ro2,
        request7 => req_ro7,
        request5 => req_ro5,
        request6 => req_ro6,
        request10 => req_ro10,
        selector2 => select2,
        selector7 => select7,
        selector5 => select5,
        selector6 => select6,
        selector10 => select10
    );
END RTL;