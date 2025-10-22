library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux_4x1 is
    port (
        I : in std_logic_vector(3 downto 0);
        S : in STD_LOGIC_VECTOR(1 downto 0);
        O : out std_logic
    );
end entity mux_4x1;

architecture rtl of mux_4x1 is

begin
O <= (I(0) and not S(1) and not S(0)) or (I(1) and not S(1) and S(0)) or (I(2) and S(1) and not S(0)) or (I(3) and S(1) and S(0));
    

end architecture;