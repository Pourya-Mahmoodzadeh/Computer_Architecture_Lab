-- Translates a binary number so that 7 segment would be able to show it
library ieee;
use ieee.std_logic_1164.all;



entity translator is 
    port (
        input : in std_logic;
        seg_data : out std_logic_vector(6 downto 0)
    );
end entity translator;



architecture behavior of translator is
begin
    COM : process (input)
    begin
        if input = '1' then 
        seg_data <= "0111111";
        else
        seg_data <= "1111101";
        end if;
    end process COM;

end architecture behavior;