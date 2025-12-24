library ieee;
use ieee.std_logic_1164.all;



entity decoder_2x4 is
    port (
        input : in std_logic_vector(1 downto 0);
        output : out std_logic_vector(3 downto 0)
    );
end entity decoder_2x4;



architecture behavior of decoder_2x4 is

begin

    P0 : process (input)
    begin
        if input = "00" then
            output <= "0001";
        else 
            if input = "01" then 
                output <= "0010";
            else 
                if input = "10" then
                    output <= "0100";
                else 
                    output <= "1111";
                end if;
            end if;
        end if;

    end process P0;

end architecture;
