library ieee;
use ieee.std_logic_1164.all;



entity full_adder is
    port (
        i1, i2, i3 : in std_logic;
        sum, cout : out std_logic
    );
end entity full_adder;



architecture rtl of full_adder is
begin
    sum <= i1 xor i2 xor i3;
    cout <= ((i1 and i2) or (i1 and i3) or (i2 and i3));
end architecture rtl;