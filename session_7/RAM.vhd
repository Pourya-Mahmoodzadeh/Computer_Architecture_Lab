library ieee;
use ieee.std_logic_1164.all;



entity RAM is
    port(
        write, read, reset_n : in std_logic;
        addr : in std_logic_vector(1 downto 0); -- 4 words
        write_data : in std_logic_vector(3 downto 0);
        read_data : out std_logic_vector(3 downto 0)
    );
end entity RAM;



architecture rtl of RAM is
    
    component D_latch 
        port(
            enable, clear_n, D : in std_logic;
            Q, Q_n : out std_logic
        );
    end component D_latch;

begin

    

end architecture;