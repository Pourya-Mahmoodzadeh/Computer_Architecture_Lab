library ieee;
use ieee.std_logic_1164.all;



entity mux_2x1 is
    port(
        i0, i1 : in std_logic;
        s : in std_logic; -- the select of the mux
        o : out std_logic
    );
end entity;



architecture rtl of mux_2x1 is
begin
    o <= (i0 and (not s)) or (i1 and s);
end architecture;