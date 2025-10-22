library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity xor_2in is
    port(
        in_1, in_2 : in std_logic;
        out_1 : out std_logic
    );
end entity xor_2in;

architecture rtl of xor_2in is
    begin
        out_1 <= in_1 xor in_2;
end architecture rtl;
