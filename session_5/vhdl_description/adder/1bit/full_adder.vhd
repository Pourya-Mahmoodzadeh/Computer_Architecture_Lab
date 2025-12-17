-- implementation of a typical full adder.

library ieee;
use ieee.std_logic_1164.all;



entity full_adder is
    port(
        i1, i2, cin : in std_logic;
        sum, cout : out std_logic
    );
end entity full_adder;



architecture rtl of full_adder is
    begin
        sum <= i1 xor i2 xor cin;
        cout <= (i1 and i2) or (i1 and cin) or (i2 and cin);

end architecture rtl;