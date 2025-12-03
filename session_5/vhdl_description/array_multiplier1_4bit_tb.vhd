library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;



entity array_multiplier1_4bit_tb is
end entity;



architecture behavior of array_multiplier1_4bit_tb is

    component array_multiplier1_4bit is 
        port (
            i1 : in std_logic_vector(3 downto 0);
            i2 : in std_logic_vector(3 downto 0);
            product : out std_logic_vector(7 downto 0)
        );
    end component;


    signal i1 : std_logic_vector(3 downto 0) := "0011";
    signal i2 : std_logic_vector(3 downto 0) := "0001";

    signal product : std_logic_vector(7 downto 0);

    signal waiting_time : time := 10 ns;

begin

    uut : component array_multiplier1_4bit
     port map(
        i1 => i1,
        i2 => i2,
        product => product
    );
    
    test : process 
    begin

        wait for waiting_time;
        i1 <= "1011";
        wait for waiting_time;
        i2 <= "0010";
        wait for waiting_time;
        i2 <= "1101";
        wait for waiting_time;
        i1 <= "1111";
        i2 <= "1111"; 
        wait for waiting_time;

        report "Testing done." severity failure;
        wait;

        
    end process;

end architecture;