library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity decoder_2to4 is
    port(
        I : in STD_LOGIC_VECTOR(1 downto 0);
        O : out STD_LOGIC_VECTOR(3 downto 0)
    );
end entity decoder_2to4;

architecture rtl of decoder_2to4 is

begin
    O(0) <= not I(1) and not I(0);
    O(1) <= not I(1) and I(0);
    O(2) <= I(1) and not I(0);
    O(3) <= I(1) and I(0);
end architecture rtl;