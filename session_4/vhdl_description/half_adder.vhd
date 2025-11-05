library ieee;
use ieee.std_logic_1164.all;



entity half_adder is
    port (
        i1, i2 : in std_logic;
        sum, cout : out std_logic
    );
end entity half_adder;



architecture rtl of half_adder is
begin
    sum <= i1 xor i2;
    cout <= i1 and i2;
end architecture rtl;