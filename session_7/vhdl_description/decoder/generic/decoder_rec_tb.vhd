library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;



entity decoder_rec_tb is
    generic(
        width : integer := 3;
        waiting_time : time := 20 ns
    );
end entity;



architecture behavior of decoder_rec_tb is

    signal input: std_logic_vector(width - 1 downto 0);
    signal output: std_logic_vector(2**width - 1 downto 0);
    signal enable: std_logic := '1';
    signal zero_output : std_logic_vector(2**width - 1 downto 0) := std_logic_vector(to_unsigned(0, 2**width));

begin

    UUT: entity work.decoder_rec 
        generic map(
            width => width
        )
        port map(
            input => input,
            output => output,
            enable => enable
        );

    TEST: process 
    begin
        for i in (2**width - 1) downto 0 loop

            input <= std_logic_vector(to_unsigned(i, width));
            wait for waiting_time;

            assert output(i) = '1'
                report "Failure at value: " & integer'image(i) & "  Enable = 1"
                severity error;

        end loop;

            wait for waiting_time;

        -- testing whether enable works or not. 

        enable <= '0';
        
        for i in (2**width - 1) downto 0 loop

            input <= std_logic_vector(to_unsigned(i, width));
            wait for waiting_time;

            assert output = zero_output
                report "Failure at value: " & integer'image(i) & "  Enable = 0"
                severity error;

        end loop;
            wait for waiting_time;
         

            report "Testing done" severity failure;
            wait;
    end process;

    

end architecture;
