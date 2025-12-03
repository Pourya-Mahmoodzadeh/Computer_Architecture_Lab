-- array multiplier implemented only using a typical 4 bit ripple carrry adder 
-- (what a waste of resources! I was had to do it like this as part of lab assignment, it's not like I liked to waste gates.)
-- BTW, I don't even like to describe a hardware using VHDL, because compared to Verilog, I am more typing than actually designing when I am using VHDL.

library ieee;
use ieee.std_logic_1164.all;



entity array_multiplier2_4bit is
    port(
        i1, i2 : in std_logic_vector(3 downto 0);
        product : out std_logic_vector(7 downto 0)
    );
end entity array_multiplier2_4bit;



architecture rtl of array_multiplier2_4bit is

    component ripple_carry_adder_4bit is 
        port (
            i1, i2 : in std_logic_vector(3 downto 0);
            cin : in std_logic;
            sum : out std_logic_vector(3 downto 0);
            cout : out std_logic
        );
    end component ripple_carry_adder_4bit;

    signal inter_product0 : std_logic_vector(3 downto 0);
    signal inter_product1 : std_logic_vector(3 downto 0);
    signal inter_product2 : std_logic_vector(3 downto 0);
    signal inter_product3 : std_logic_vector(3 downto 0);

    signal inter_sum0 : std_logic_vector(4 downto 0);
    signal inter_sum1 : std_logic_vector(4 downto 0);
    signal inter_sum2 : std_logic_vector(4 downto 0);

    signal tmp_for_inter_product0 : std_logic_vector(3 downto 0);

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

    tmp_for_inter_product0(3) <= '0';
    tmp_for_inter_product0(2 downto 0) <= inter_product0(3 downto 1);

    product(0) <= inter_product0(0);

    adder0 : component ripple_carry_adder_4bit
     port map(
        i1 => tmp_for_inter_product0,
        i2 => inter_product1(3 downto 0),
        cin => '0',
        sum => inter_sum0(3 downto 0),
        cout => inter_sum0(4)
    );

    product(1) <= inter_sum0(0);

    adder1 : component ripple_carry_adder_4bit
     port map(
        i1 => inter_sum0(4 downto 1),
        i2 => inter_product2(3 downto 0),
        cin => '0',
        sum => inter_sum1(3 downto 0),
        cout => inter_sum1(4)
    );

    product(2) <= inter_sum1(0);

    adder2 : component ripple_carry_adder_4bit
     port map(
        i1 => inter_sum1(4 downto 1),
        i2 => inter_product3(3 downto 0),
        cin => '0',
        sum => inter_sum2(3 downto 0),
        cout => inter_sum2(4)
    );

    product(7 downto 3) <= inter_sum2(4 downto 0);    

end architecture;