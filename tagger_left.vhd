LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY tagger_left IS
    PORT (
        request1, request4, request5, request6, request9 : IN STD_LOGIC_VECTOR(12 - 1 DOWNTO 0);
        grant : OUT STD_LOGIC_VECTOR(5 - 1 DOWNTO 0)
    );
END ENTITY tagger_left;

ARCHITECTURE BEHAV OF tagger_left IS
    TYPE tags IS (N, S, E, W, L, U);
    SIGNAL status1, status4, status5, status6, status9 : tags;
    SIGNAL dest1, dest4, dest5, dest6, dest9 : UNSIGNED(5 - 1 DOWNTO 0);
    SIGNAL xdest1, xdest4, xdest5, xdest6, xdest9 : INTEGER;
    SIGNAL ydest1, ydest4, ydest5, ydest6, ydest9 : INTEGER;
    SIGNAL G1, G4, G5, G6, G9 : STD_LOGIC;
BEGIN

    dest1 <= UNSIGNED(request1(5 - 1 DOWNTO 0));
    dest4 <= UNSIGNED(request4(5 - 1 DOWNTO 0));
    dest5 <= UNSIGNED(request5(5 - 1 DOWNTO 0));
    dest6 <= UNSIGNED(request6(5 - 1 DOWNTO 0));
    dest9 <= UNSIGNED(request9(5 - 1 DOWNTO 0));

    xdest1 <= to_integer(dest1 MOD 4);
    xdest4 <= to_integer(dest4 MOD 4);
    xdest5 <= to_integer(dest5 MOD 4);
    xdest6 <= to_integer(dest6 MOD 4);
    xdest9 <= to_integer(dest9 MOD 4);

    ydest1 <= to_integer(dest1 / 4);
    ydest4 <= to_integer(dest4 / 4);
    ydest5 <= to_integer(dest5 / 4);
    ydest6 <= to_integer(dest6 / 4);
    ydest9 <= to_integer(dest9 / 4);

    status1 <=
        U WHEN ydest1 = 0 AND xdest1 = 0 ELSE
        L WHEN ydest1 = 1 AND xdest1 = 1 ELSE
        S WHEN ydest1 = 2 AND xdest1 = 1 ELSE
        W WHEN ydest1 = 1 AND xdest1 = 0 ELSE
        E;

    status4 <=
        U WHEN ydest4 = 0 AND xdest4 = 0 ELSE
        L WHEN ydest4 = 1 AND xdest4 = 1 ELSE
        S WHEN ydest4 = 2 AND xdest4 = 1 ELSE
        N WHEN ydest4 = 0 AND xdest4 = 1 ELSE
        E;

    status5 <=
        U WHEN ydest5 = 0 AND xdest5 = 0 ELSE
        S WHEN ydest5 = 2 AND xdest5 = 1 ELSE
        N WHEN ydest5 = 0 AND xdest5 = 1 ELSE
        W WHEN ydest5 = 1 AND xdest5 = 0 ELSE
        E;

    status9 <=
        U WHEN ydest9 = 0 AND xdest9 = 0 ELSE
        L WHEN ydest9 = 1 AND xdest9 = 1 ELSE
        N WHEN ydest9 = 0 AND xdest9 = 1 ELSE
        W WHEN ydest9 = 1 AND xdest9 = 0 ELSE
        E;

    status6 <=
        U WHEN ydest6 = 0 AND xdest6 = 0 ELSE
        S WHEN ydest6 = 2 AND xdest6 = 1 ELSE
        N WHEN ydest6 = 0 AND xdest6 = 1 ELSE
        W WHEN ydest6 = 1 AND xdest6 = 0 ELSE
        L;
        
    G1 <=
        '0' WHEN status1 = U ELSE
        '1';

    G4 <=
        '0' WHEN status4 = U ELSE
        '0' WHEN status1 = L AND status4 = L ELSE
        '0' WHEN status1 = S AND status4 = S ELSE
        '0' WHEN status1 = E AND status4 = E ELSE
        '1';

    G5 <=
        '0' WHEN status5 = U ELSE
        '0' WHEN status1 = S AND status5 = S ELSE
        '0' WHEN status1 = E AND status5 = E ELSE
        '0' WHEN status1 = W AND status5 = W ELSE
        '0' WHEN status4 = S AND status5 = S ELSE
        '0' WHEN status4 = E AND status5 = E ELSE
        '0' WHEN status4 = N AND status5 = N ELSE
        '1';

    G6 <=
        '0' WHEN status6 = U ELSE
        '0' WHEN status1 = S AND status6 = S ELSE
        '0' WHEN status1 = L AND status6 = L ELSE
        '0' WHEN status1 = W AND status6 = W ELSE
        '0' WHEN status4 = S AND status6 = S ELSE
        '0' WHEN status4 = L AND status6 = L ELSE
        '0' WHEN status4 = N AND status6 = N ELSE
        '0' WHEN status5 = S AND status6 = S ELSE
        '0' WHEN status5 = W AND status6 = W ELSE
        '0' WHEN status5 = N AND status6 = N ELSE
        '1';

    G9 <=
        '0' WHEN status9 = U ELSE
        '0' WHEN status1 = E AND status9 = E ELSE
        '0' WHEN status1 = L AND status9 = L ELSE
        '0' WHEN status1 = W AND status9 = W ELSE
        '0' WHEN status4 = E AND status9 = E ELSE
        '0' WHEN status4 = L AND status9 = L ELSE
        '0' WHEN status4 = N AND status9 = N ELSE
        '0' WHEN status5 = E AND status9 = E ELSE
        '0' WHEN status5 = W AND status9 = W ELSE
        '0' WHEN status5 = N AND status9 = N ELSE
        '0' WHEN status6 = L AND status9 = L ELSE
        '0' WHEN status6 = W AND status9 = W ELSE
        '0' WHEN status6 = N AND status9 = N ELSE
        '1';

    grant <= G9 & G6 & G5 & G4 & G1;

END ARCHITECTURE BEHAV;