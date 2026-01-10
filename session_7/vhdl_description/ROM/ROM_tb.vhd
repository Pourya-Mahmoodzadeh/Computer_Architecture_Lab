-- a testbench of a never-to-be-used-and-useless mux!
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;



entity ROM_tb is 
end entity;



architecture behavior of ROM_tb is

    component ROM is 
        port (
            data : out std_logic_vector(3 downto 0);
            addr : in std_logic_vector(1 downto 0)        
        );
    end component;

    signal data : std_logic_vector(3 downto 0);
    signal addr : std_logic_vector(1 downto 0) := "00";

    constant waiting_time : time := 20 ns;

begin

    UUT : component ROM
     port map(
        data => data,
        addr => addr
    );

    TEST : process 
    begin
        for i in 1 to 3 loop 
            wait for waiting_time;
            addr <= std_logic_vector(to_unsigned(i, 2));
        end loop;
        wait for waiting_time;
        report "Testing done." severity note;
        wait;
    end process;  
end architecture;
