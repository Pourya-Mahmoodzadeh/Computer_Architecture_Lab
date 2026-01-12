library ieee;
use ieee.std_logic_1164.all;



entity simillarity_checker is 
    generic(
        DATA_WIDTH : positive
    );
    port(
        mask, data1, data2 : in std_logic_vector(DATA_WIDTH - 1 downto 0);
        simillar : out std_logic
    );
end entity;



architecture rtl of simillarity_checker is
    signal simillartiy_of_bits : std_logic_vector(DATA_WIDTH - 1 downto 0);
begin
    simillartiy_of_bits <= (data1 xnor data2) or mask;

    GENERIC_AND_INST : entity work.generic_and
     generic map(
        WIDTH => DATA_WIDTH
    )
     port map(
        input => simillartiy_of_bits,
        output => simillar
    );

    

end architecture;