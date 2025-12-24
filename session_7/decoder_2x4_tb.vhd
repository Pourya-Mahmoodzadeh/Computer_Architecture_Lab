library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;



entity decoder_2x4_tb is
end entity;



architecture behavior of decoder_2x4_tb is 

    component decoder_2x4
        port (
            input : in std_logic_vector(1 downto 0);
            output : out std_logic_vector(3 downto 0)
        );
    end component;

    signal input : std_logic_vector(1 downto 0) := "00";
    signal output : std_logic_vector(3 downto 0);
    signal waiting_time : time := 20 ns;

begin

    uut: component decoder_2x4
     port map(
        input => input,
        output => output
    );

    TEST : process 
    begin
        wait for waiting_time;
        input <= "01";
        wait for waiting_time;
        input <= "10";
        wait for waiting_time;
        input <= "11";
        wait for waiting_time;
        wait for waiting_time;
        report "Testing done." severity failure;
        wait;

    end process;


    

end architecture;