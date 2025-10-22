library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity encoder_4to1 is
    port(
        I : in std_logic_vector(3 downto 0);
        O : out std_logic_vector(1 downto 0);
        V : out std_logic 
    );
end entity encoder_4to1;

architecture rtl of encoder_4to1 is

begin
    O(0) <= I(0) and I(1);
    O(1) <= I(1) and I(3);
    V <= I(0) or I(1) or I(2) or I(3);
end architecture rtl;