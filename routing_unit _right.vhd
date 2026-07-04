LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY routing_unit_right IS
    PORT (
        request2, request7, request5, request6, request10 : IN STD_LOGIC_VECTOR(12 - 1 DOWNTO 0);
        selector2, selector7, selector5, selector6, selector10 : OUT STD_LOGIC_VECTOR(3 - 1 DOWNTO 0)
    );
END ENTITY routing_unit_right;

ARCHITECTURE BEHAV OF routing_unit_right IS

    SIGNAL surc2, surc7, surc5, surc6, surc10 : STD_LOGIC_VECTOR(5 - 1 DOWNTO 0);
    SIGNAL dest2, dest7, dest5, dest6, dest10 : STD_LOGIC_VECTOR(5 - 1 DOWNTO 0);

BEGIN
    surc2 <= request2(10 - 1 DOWNTO 5);
    surc7 <= request7(10 - 1 DOWNTO 5);
    surc5 <= request5(10 - 1 DOWNTO 5);
    surc6 <= request6(10 - 1 DOWNTO 5);
    surc10 <= request10(10 - 1 DOWNTO 5);
    ------------------------------------
    dest2 <= request2(5 - 1 DOWNTO 0);
    dest7 <= request7(5 - 1 DOWNTO 0);
    dest5 <= request5(5 - 1 DOWNTO 0);
    dest6 <= request6(5 - 1 DOWNTO 0);
    dest10 <= request10(5 - 1 DOWNTO 0);

    selector2 <=
        "000" WHEN dest5 = "00010" ELSE
        "001" WHEN dest6 = "00010" ELSE
        "010" WHEN dest7 = "00010" ELSE
        "011" WHEN dest10 = "00010" ELSE
        "111";
    --
    selector6 <=
        "000" WHEN dest2 = "00110" ELSE
        "001" WHEN dest5 = "00110" ELSE
        "010" WHEN dest7 = "00110" ELSE
        "011" WHEN dest10 = "00110" ELSE
        "111";
    --   
    selector7 <=
        "000" WHEN dest2 = "00111" ELSE
        "001" WHEN dest5 = "00111" ELSE
        "010" WHEN dest6 = "00111" ELSE
        "011" WHEN dest10 = "00111" ELSE
        "111";
    --   
    selector10 <=
        "000" WHEN dest2 = "01010" ELSE
        "001" WHEN dest5 = "01010" ELSE
        "010" WHEN dest6 = "01010" ELSE
        "011" WHEN dest7 = "01010" ELSE
        "111";
    --   
    selector5 <=
        "000" WHEN surc2 = "00010" and (dest2 = "00100" or dest2 = "00001" or dest2 = "00101" or dest2 = "01001") ELSE
        "001" WHEN surc6 = "00110" and (dest6 = "00100" or dest6 = "00001" or dest6 = "00101" or dest6 = "01001") ELSE
        "010" WHEN surc7 = "00111" and (dest7 = "00100" or dest7 = "00001" or dest7 = "00101" or dest7 = "01001") ELSE
        "011" WHEN surc10 = "01010" and (dest10 = "00100" or dest10 = "00001" or dest10 = "00101" or dest10 = "01001") ELSE
        "111";

END ARCHITECTURE BEHAV;