-- half adders and full adders are used to implement a 4-bit array multiplier


library ieee;
use ieee.std_logic_1164.all;



entity array_multiplier1_4bit is
    port (
        i1 : in std_logic_vector(3 downto 0);
        i2 : in std_logic_vector(3 downto 0);
        product : out std_logic_vector(7 downto 0)
    );    
end entity array_multiplier1_4bit;



architecture rtl of array_multiplier1_4bit is 

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

    signal inter_sum0 : std_logic_vector(4 downto 0);
    signal inter_cout0 : std_logic_vector(2 downto 0);

    signal inter_sum1 : std_logic_vector(4 downto 0);
    signal inter_cout1 : std_logic_vector(2 downto 0);

    signal inter_sum2 : std_logic_vector(4 downto 0);
    signal inter_cout2 : std_logic_vector(2 downto 0);


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

        HA01 : component half_adder -- half adder working with inter product 0 and it's second bit.
         port map(
            i1 => inter_product0(1),
            i2 => inter_product1(0),
            sum => inter_sum0(0),
            cout => inter_cout0(0)
        );

        FA02 : full_adder
         port map(
            i1 => inter_product0(2),
            i2 => inter_product1(1),
            cin => inter_cout0(0),
            sum => inter_sum0(1),
            cout => inter_cout0(1)
        );

        FA03 : full_adder
         port map(
            i1 => inter_product0(3),
            i2 => inter_product1(2),
            cin => inter_cout0(1),
            sum => inter_sum0(2),
            cout => inter_cout0(2)
        );

        HA04 : half_adder
         port map(
            i1 => inter_product1(3),
            i2 => inter_cout0(2),
            sum => inter_sum0(3),
            cout => inter_sum0(4)
        );

        product(1) <= inter_sum0(0);

        HA11 : half_adder -- not readable, I know! (sorry for that!) HAxy deals with product x + 1.
         port map(
            i1 => inter_sum0(1),
            i2 => inter_product2(0),
            sum => inter_sum1(0),
            cout => inter_cout1(0)
        );

        FA12 : full_adder
         port map(
            i1 => inter_sum0(2),
            i2 => inter_product2(1),
            cin => inter_cout1(0),
            sum => inter_sum1(1),
            cout => inter_cout1(1)
        );

        FA13 : full_adder
         port map(
            i1 => inter_sum0(3),
            i2 => inter_product2(2),
            cin => inter_cout1(1),
            sum => inter_sum1(2),
            cout => inter_cout1(2)
        );

        FA14 : full_adder
         port map(
            i1 => inter_sum0(4),
            i2 => inter_product2(3),
            cin => inter_cout1(2),
            sum => inter_sum1(3),
            cout => inter_sum1(4)
        );

        product(2) <= inter_sum1(0);

        HA21 : half_adder -- from here till "MARK", the pattern can be repeated to expand this to n arbitrary bits
         port map(
            i1 => inter_sum1(1),
            i2 => inter_product3(0),
            sum => inter_sum2(0),
            cout => inter_cout2(0)
        );

        FA22 : full_adder
         port map(
            i1 => inter_sum1(2),
            i2 => inter_product3(1),
            cin => inter_cout2(0),
            sum => inter_sum2(1),
            cout => inter_cout2(1)
        );

        FA23 : full_adder
         port map(
            i1 => inter_sum1(3),
            i2 => inter_product3(2),
            cin => inter_cout2(1),
            sum => inter_sum2(2),
            cout => inter_cout2(2)
        );

        FA24 : full_adder
         port map(
            i1 => inter_sum1(4),
            i2 => inter_product3(3),
            cin => inter_cout2(2),
            sum => inter_sum2(3),
            cout => inter_sum2(4)
        );

        product(3) <= inter_sum2(0);

        -- MARK

        product(7 downto 4) <= inter_sum2(4 downto 1);


end architecture rtl;
