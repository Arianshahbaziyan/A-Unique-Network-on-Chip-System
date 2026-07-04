LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY tagger_right IS
    PORT (
        request2, request7, request5, request6, request10 : IN STD_LOGIC_VECTOR(12 - 1 DOWNTO 0);
        grant : OUT STD_LOGIC_VECTOR(5 - 1 DOWNTO 0)
    );
END ENTITY tagger_right;

ARCHITECTURE BEHAV OF tagger_right IS
    TYPE tags IS (N, S, E, W, L, U);
    SIGNAL status2, status7, status5, status6, status10 : tags;
    SIGNAL dest2, dest7, dest5, dest6, dest10 : UNSIGNED(5 - 1 DOWNTO 0);
    SIGNAL xdest2, xdest7, xdest5, xdest6, xdest10 : INTEGER;
    SIGNAL ydest2, ydest7, ydest5, ydest6, ydest10 : INTEGER;
    SIGNAL G2, G7, G5, G6, G10 : STD_LOGIC;
BEGIN

    dest2 <= UNSIGNED(request2(5 - 1 DOWNTO 0));
    dest7 <= UNSIGNED(request7(5 - 1 DOWNTO 0));
    dest5 <= UNSIGNED(request5(5 - 1 DOWNTO 0));
    dest6 <= UNSIGNED(request6(5 - 1 DOWNTO 0));
    dest10 <= UNSIGNED(request10(5 - 1 DOWNTO 0));

    xdest2 <= to_integer(dest2 MOD 4);
    xdest7 <= to_integer(dest7 MOD 4);
    xdest5 <= to_integer(dest5 MOD 4);
    xdest6 <= to_integer(dest6 MOD 4);
    xdest10 <= to_integer(dest10 MOD 4);

    ydest2 <= to_integer(dest2 / 4);
    ydest7 <= to_integer(dest7 / 4);
    ydest5 <= to_integer(dest5 / 4);
    ydest6 <= to_integer(dest6 / 4);
    ydest10 <= to_integer(dest10 / 4);

    status2 <=
        U WHEN ydest2 = 0 AND xdest2 = 0 ELSE
        L WHEN ydest2 = 1 AND xdest2 = 2 ELSE
        S WHEN ydest2 = 2 AND xdest2 = 2 ELSE
        E WHEN ydest2 = 1 AND xdest2 = 3 ELSE
        W;

    status7 <=
        U WHEN ydest7 = 0 AND xdest7 = 0 ELSE
        L WHEN ydest7 = 1 AND xdest7 = 2 ELSE
        S WHEN ydest7 = 2 AND xdest7 = 2 ELSE
        N WHEN ydest7 = 0 AND xdest7 = 2 ELSE
        W;

    status6 <=
        U WHEN ydest6 = 0 AND xdest6 = 0 ELSE
        S WHEN ydest6 = 2 AND xdest6 = 2 ELSE
        N WHEN ydest6 = 0 AND xdest6 = 2 ELSE
        E WHEN ydest6 = 1 AND xdest6 = 3 ELSE
        W;

    status10 <=
        U WHEN ydest10 = 0 AND xdest10 = 0 ELSE
        L WHEN ydest10 = 1 AND xdest10 = 2 ELSE
        N WHEN ydest10 = 0 AND xdest10 = 2 ELSE
        E WHEN ydest10 = 1 AND xdest10 = 3 ELSE
        W;

    status5 <=
        U WHEN ydest5 = 0 AND xdest5 = 0 ELSE
        S WHEN ydest5 = 2 AND xdest5 = 2 ELSE
        N WHEN ydest5 = 0 AND xdest5 = 2 ELSE
        E WHEN ydest5 = 1 AND xdest5 = 3 ELSE
        L;

    G2 <=
        '0' WHEN status2 = U ELSE
        '1';

    G5 <=
        '0' WHEN status5 = U ELSE
        '0' WHEN status2 = L AND status5 = L ELSE
        '0' WHEN status2 = S AND status5 = S ELSE
        '0' WHEN status2 = E AND status5 = E ELSE
        '1';

    G6 <=
        '0' WHEN status6 = U ELSE
        '0' WHEN status2 = W AND status6 = W ELSE
        '0' WHEN status2 = S AND status6 = S ELSE
        '0' WHEN status2 = E AND status6 = E ELSE
        '0' WHEN status5 = S AND status6 = S ELSE
        '0' WHEN status5 = E AND status6 = E ELSE
        '0' WHEN status5 = N AND status6 = N ELSE
        '1';

    G7 <=
        '0' WHEN status7 = U ELSE
        '0' WHEN status2 = W AND status7 = W ELSE
        '0' WHEN status2 = S AND status7 = S ELSE
        '0' WHEN status2 = L AND status7 = L ELSE
        '0' WHEN status5 = S AND status7 = S ELSE
        '0' WHEN status5 = L AND status7 = L ELSE
        '0' WHEN status5 = N AND status7 = N ELSE
        '0' WHEN status6 = W AND status7 = W ELSE
        '0' WHEN status6 = S AND status7 = S ELSE
        '0' WHEN status6 = N AND status7 = N ELSE
        '1';

    G10 <=
        '0' WHEN status10 = U ELSE
        '0' WHEN status2 = W AND status10 = W ELSE
        '0' WHEN status2 = E AND status10 = E ELSE
        '0' WHEN status2 = L AND status10 = L ELSE
        '0' WHEN status5 = E AND status10 = E ELSE
        '0' WHEN status5 = L AND status10 = L ELSE
        '0' WHEN status5 = N AND status10 = N ELSE
        '0' WHEN status6 = W AND status10 = W ELSE
        '0' WHEN status6 = E AND status10 = E ELSE
        '0' WHEN status6 = N AND status10 = N ELSE
        '0' WHEN status7 = W AND status10 = W ELSE
        '0' WHEN status7 = L AND status10 = L ELSE
        '0' WHEN status7 = N AND status10 = N ELSE
        '1';

    grant <= G10 & G7 & G6 & G5 & G2;

END ARCHITECTURE BEHAV;