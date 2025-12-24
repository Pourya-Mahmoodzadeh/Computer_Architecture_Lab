library ieee;
use ieee.std_logic_1164.all;



entity inouter is
    port(
        cir_out : in std_logic_vector(3 downto 0);
        cir_in : out std_logic_vector(3 downto 0);
        in_out : inout std_logic_vector(3 downto 0);
        choose_cir_out, choose_cir_in : in std_logic
    );
end entity inouter;



architecture behavior of inouter is

begin

    P0 : process (choose_cir_out, choose_cir_in)
    begin
        if choose_cir_out = '1' then
            in_out <= cir_out;
            cir_in <= cir_out;
        else
            if choose_cir_in = '1' then
                cir_in <= in_out;
            end if;
        end if;
    end process P0;
end architecture;