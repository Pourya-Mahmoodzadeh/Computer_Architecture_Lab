library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity or_2in is
    port(
        in_1, in_2 : in std_logic;
        out_1 : out std_logic
    );
end entity or_2in;

architecture rtl of or_2in is
    begin
        out_1 <= in_1 or in_2;
end architecture rtl;
