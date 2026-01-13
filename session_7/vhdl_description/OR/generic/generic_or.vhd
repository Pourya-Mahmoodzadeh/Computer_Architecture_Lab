library ieee;
use ieee.std_logic_1164.all;



entity generic_or is 
    generic(
        WIDTH : positive
    );
    port(
        input : in std_logic_vector(WIDTH - 1 downto 0);
        output : out std_logic
    );
end entity;



architecture behavior of generic_or is

    signal init_or : std_logic;
    signal step_in : std_logic_vector(WIDTH - 1 downto 0); -- tell me if you know a better way than to relying on synthesis tool smartness to trim this for some cases.

begin

    init_or <= input(0) or input(1);

    BASIS: if WIDTH = 2 generate -- As always, not knowing how to do it with a loop and not having access to the internet, I used recursion.
        output <= init_or;
    end generate;

    STEP : if WIDTH > 2 generate 
        step_in(WIDTH - 1 downto 1) <= init_or & input(WIDTH - 1 downto 2);
        GENERIC_OR_INST : entity work.generic_or 
            generic map(
                WIDTH => WIDTH - 1
            )
            port map(
                input => step_in(WIDTH - 1 downto 1),
                output => output
            );
        end generate;


    

end architecture;