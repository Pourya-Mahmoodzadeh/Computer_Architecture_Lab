-- This has the same logic as array multiplier, but carry save adder logic is used to do the addition.

library ieee;
use ieee.std_logic_1164.all;



entity carry_save_multiplier_4bit is
    port(
        i1, i2 : in std_logic_vector(3 downto 0);
        product : out std_logic_vector(7 downto 0)
    );
end entity carry_save_multiplier_4bit;



architecture rtl of carry_save_multiplier_4bit is

    component half_adder is 
        port(
        i1, i2 : in std_logic;
        sum, cout : out std_logic
        );
    end component half_adder;

    component full_adder is 
        port(
        i1, i2, cin : in std_logic;
        sum, cout : out std_logic
        );
    end component full_adder;

    signal inter_product0 : std_logic_vector(3 downto 0);
    signal inter_product1 : std_logic_vector(3 downto 0);
    signal inter_product2 : std_logic_vector(3 downto 0);
    signal inter_product3 : std_logic_vector(3 downto 0);

    signal sum0 : std_logic_vector(2 downto 0);
    signal sum1 : std_logic_vector(3 downto 0);

    signal sum2 : std_logic_vector(1 downto 0); -- practically impossible to understand unless I provide you with my notes, or you are too good, sorry!
    signal sum3 : std_logic_vector(2 downto 0);

    signal sum4 : std_logic;
    signal sum5 : std_logic_vector(1 downto 0);

    signal sum6 : std_logic;

    signal sum7 : std_logic;

begin

    inter_product0(0) <= i1(0) and i2(0);
    inter_product0(1) <= i1(0) and i2(1);
    inter_product0(2) <= i1(0) and i2(2);
    inter_product0(3) <= i1(0) and i2(3);

    inter_product1(0) <= i1(1) and i2(0);
    inter_product1(1) <= i1(1) and i2(1);
    inter_product1(2) <= i1(1) and i2(2);
    inter_product1(3) <= i1(1) and i2(3);

    inter_product2(0) <= i1(2) and i2(0);
    inter_product2(1) <= i1(2) and i2(1);
    inter_product2(2) <= i1(2) and i2(2);
    inter_product2(3) <= i1(2) and i2(3);

    inter_product3(0) <= i1(3) and i2(0);
    inter_product3(1) <= i1(3) and i2(1);
    inter_product3(2) <= i1(3) and i2(2);
    inter_product3(3) <= i1(3) and i2(3);

    product(0) <= inter_product0(0);

    HA0 : half_adder
     port map(
        i1 => inter_product0(1),
        i2 => inter_product1(0),
        sum => product(1),
        cout => sum1(0)
    );

    FA0 : full_adder
     port map(
        i1 => inter_product0(2),
        i2 => inter_product1(1),
        cin => inter_product2(0),
        sum => sum0(0),
        cout => sum1(1)
    );

    FA1 : full_adder
     port map(
        i1 => inter_product0(3),
        i2 => inter_product1(2),
        cin => inter_product2(1),
        sum => sum0(1),
        cout => sum1(2)
    );

    FA2 : full_adder
     port map(
        i1 => inter_product1(3),
        i2 => inter_product2(2),
        cin => inter_product3(1),
        sum => sum0(2),
        cout => sum1(3)
    );

    HA1 : half_adder
     port map(
        i1 => sum0(0),
        i2 => sum1(0),
        sum => product(2),
        cout => sum3(0)
    );

    FA3 : full_adder
     port map(
        i1 => sum0(1),
        i2 => sum1(1),
        cin => inter_product3(0),
        sum => sum2(0),
        cout => sum3(1)
    );

    FA4 : full_adder
     port map(
        i1 => sum1(3),
        i2 => inter_product2(3),
        cin => inter_product3(2),
        sum => sum2(1),
        cout => sum3(2)
    );

    HA2 : half_adder
     port map(
        i1 => sum2(0),
        i2 => sum3(0),
        sum => product(3),
        cout => sum5(0)
    );

    FA5 : full_adder
     port map(
        i1 => sum3(1),
        i2 => sum0(2),
        cin => sum1(2),
        sum => sum4,
        cout => sum5(1)
    );

    HA3 : half_adder
     port map(
        i1 => sum4,
        i2 => sum5(0),
        sum => product(4),
        cout => sum6
    );

    FA6 : full_adder
     port map(
        i1 => sum6,
        i2 => sum2(1),
        cin => sum5(1),
        sum => product(5),
        cout => sum7
    );

    FA7 : full_adder
     port map(
        i1 => sum7,
        i2 => sum3(2),
        cin => inter_product3(3),
        sum => product(6),
        cout => product(7)
    );




    

end architecture;