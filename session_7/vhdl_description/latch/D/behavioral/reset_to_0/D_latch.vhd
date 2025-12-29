library ieee;
use ieee.std_logic_1164.all;



entity D_latch is
    port(
        enable, clear_n, D : in std_logic;
        Q, Q_n : out std_logic
    );
end entity D_latch;



architecture behavior of D_latch is

begin

    P0 : process (enable, clear_n, D)
    begin
        if clear_n = '0' then
            Q <= '0';
            Q_n <= '1';
        else 
            if enable = '1' then
                Q <= D;
                Q_n <= not D;
            end if;
        end if;
    end process P0;
    

end architecture;