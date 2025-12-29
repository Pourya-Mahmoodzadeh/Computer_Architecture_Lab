library ieee;
use ieee.std_logic_1164.all;



entity D_latch_async_fill is
    port(
        enable, fill_n, D : in std_logic;
        Q, Q_n : out std_logic
    );
end entity;



architecture behavior of D_latch_async_fill is

begin

    P0 : process (enable, fill_n, D)
    begin
        if fill_n = '0' then
            Q <= '1';
            Q_n <= '0';
        else 
            if enable = '1' then
                Q <= D;
                Q_n <= not D;
            end if;
        end if;
    end process P0;
    

end architecture;