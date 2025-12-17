library ieee;
use ieee.std_logic_1164.all;



entity T_FF is
    port (
        T, resetn, clk : in std_logic; -- The n after an input implies that it is active-low. (read: input-not)
        Q, Qn : out std_logic
    );
end entity T_FF;



architecture rtl of T_FF is 

    signal s_Q : std_logic := '0';
    signal s_Qn : std_logic := '1';

begin

    process (clk, resetn)
    begin
        if resetn = '0' then
            s_Q <= '0';
            s_Qn <= '1';
        else 
            if rising_edge(clk) then
                if T = '1' then
                        s_Q <= not s_Q;
                        s_Qn <= not s_Qn;
                else 
                        s_Q <= s_Q;
                        s_Qn <= s_Qn;
                end if;
            end if;
        end if;
    end process;

    Q <= s_Q;
    Qn <= s_Qn;


end architecture rtl;