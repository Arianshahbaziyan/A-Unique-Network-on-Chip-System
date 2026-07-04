LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY routing_unit_left IS
    PORT (
        request1, request4, request5, request6, request9 : IN STD_LOGIC_VECTOR(12 - 1 DOWNTO 0);
        selector1, selector4, selector5, selector6, selector9 : OUT STD_LOGIC_VECTOR(3 - 1 DOWNTO 0)
    );
END ENTITY routing_unit_left;

ARCHITECTURE BEHAV OF routing_unit_left IS

    SIGNAL surc1, surc4, surc5, surc6, surc9 : STD_LOGIC_VECTOR(5 - 1 DOWNTO 0);
    SIGNAL dest1, dest4, dest5, dest6, dest9 : STD_LOGIC_VECTOR(5 - 1 DOWNTO 0);

BEGIN
    surc1 <= request1(10 - 1 DOWNTO 5);
    surc4 <= request4(10 - 1 DOWNTO 5);
    surc5 <= request5(10 - 1 DOWNTO 5);
    surc6 <= request6(10 - 1 DOWNTO 5);
    surc9 <= request9(10 - 1 DOWNTO 5);
    ------------------------------------
    dest1 <= request1(5 - 1 DOWNTO 0);
    dest4 <= request4(5 - 1 DOWNTO 0);
    dest5 <= request5(5 - 1 DOWNTO 0);
    dest6 <= request6(5 - 1 DOWNTO 0);
    dest9 <= request9(5 - 1 DOWNTO 0);

    selector1 <=
        "000" WHEN dest4 = "00001" ELSE
        "001" WHEN dest5 = "00001" ELSE
        "010" WHEN dest6 = "00001" ELSE
        "011" WHEN dest9 = "00001" ELSE
        "111";
    --
    selector4 <=
        "000" WHEN dest1 = "00100" ELSE
        "001" WHEN dest5 = "00100" ELSE
        "010" WHEN dest6 = "00100" ELSE
        "011" WHEN dest9 = "00100" ELSE
        "111";
    --   
    selector5 <=
        "000" WHEN dest1 = "00101" ELSE
        "001" WHEN dest4 = "00101" ELSE
        "010" WHEN dest6 = "00101" ELSE
        "011" WHEN dest9 = "00101" ELSE
        "111";
    --   
    selector9 <=
        "000" WHEN dest1 = "01001" ELSE
        "001" WHEN dest4 = "01001" ELSE
        "010" WHEN dest5 = "01001" ELSE
        "011" WHEN dest6 = "01001" ELSE
        "111";
    --   
    selector6 <=
        "000" WHEN surc1 = "00001" and (dest1 = "00110" or dest1 = "00010" or dest1 = "00111" or dest1 = "01010") ELSE
        "001" WHEN surc4 = "00100" and (dest4 = "00110" or dest4 = "00010" or dest4 = "00111" or dest4 = "01010") ELSE
        "010" WHEN surc5 = "00101" and (dest5 = "00110" or dest5 = "00010" or dest5 = "00111" or dest5 = "01010") ELSE
        "011" WHEN surc9 = "01001" and (dest9 = "00110" or dest9 = "00010" or dest9 = "00111" or dest9 = "01010") ELSE
        "111";

END ARCHITECTURE BEHAV;