library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity D_FF is
    port (
        D, clk, load, reset : in std_logic; -- Warning: the reest is active-low
        Q, Qn : out std_logic
    );
end entity D_FF;



architecture rtl of D_FF is
begin
    process (clk, reset)
    begin
        if reset = '0' then
            Q <= '0';
            Qn <= '1';
        else
            if rising_edge(clk) then
                if load = '1' then
                     Q <= D;
                     Qn <= not D;
                end if;
            end if;
        end if;
    end process;
end architecture rtl;
