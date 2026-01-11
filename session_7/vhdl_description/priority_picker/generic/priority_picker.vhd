library ieee;
use ieee.std_logic_1164.all;



entity priority_picker is 
    generic (
        WIDTH : positive := 4
    );
    port(
        input : in std_logic_vector(WIDTH - 1 downto 0); -- closer to LSB : higher priority
        output : out std_logic_vector(WIDTH - 1 downto 0)
    );
end entity;



architecture rtl of priority_picker is

    subtype data_type is std_logic_vector(WIDTH - 1 downto 0);

    signal input0n : std_logic;
    signal to_be_anded : data_type;
    signal new_input : data_type;

begin

    input0n <= not input(0);

    output(0) <= input(0);

    STEP: if WIDTH > 1 generate -- I used recucrsive approach only because there was no internet and I didn't know how to AND arbitrary number of bits
        REC_GEN: for i in 1 to WIDTH - 1 generate 
            new_input(i) <= input0n and input(i);
        end generate;
        
        USE_LAST_STEP: entity work.priority_picker 
            generic map( 
                WIDTH => (WIDTH - 1)
            )
            port map(
                input => new_input(WIDTH - 1 downto 1),
                output => output(WIDTH - 1 downto 1)
            );

    end generate;



    

end architecture;