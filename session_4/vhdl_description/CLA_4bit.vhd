library ieee;
use ieee.std_logic_1164.all;



entity CLA_4bit is 
    port (
        i1, i2 : in std_logic_vector(3 downto 0);
        sum : out std_logic_vector(3 downto 0);
        cout : out std_logic
    );
end entity CLA_4bit;



architecture rtl of CLA_4bit is
    
    signal G : std_logic_vector(3 downto 0);
    signal P : std_logic_vector(3 downto 0);
    signal C : std_logic_vector(3 downto 0);

begin

    G(0) <= i1(0) and i2(0);
    G(1) <= i1(1) and i2(1);
    G(2) <= i1(2) and i2(2);
    G(3) <= i1(3) and i2(3);

    --P(0) <= i1(0) or i2(0);
    P(0) <= '0';
    P(1) <= i1(1) or i2(1);
    P(2) <= i1(2) or i2(2);
    P(3) <= i1(3) or i2(3);

    C(0) <= G(0);
    C(1) <= G(1) or (P(1) and G(0));
    C(2) <= G(2)  or (P(2) and (G(1) or (P(1) and G(0))));
    C(3) <= G(3) or (P(3) and (G(2)  or (P(2) and (G(1) or (P(1) and G(0))))));

    sum(0) <= i1(0) xor i2(0);
    sum(1) <= i1(1) xor i2(1) xor C(0);
    sum(2) <= i1(2) xor i2(2) xor C(1);
    sum(3) <= i1(3) xor i2(3) xor C(2);

    cout <= C(3);


end architecture rtl;