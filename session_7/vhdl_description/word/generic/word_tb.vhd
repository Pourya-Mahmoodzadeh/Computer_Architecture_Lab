library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;



entity word_tb is
    generic(
        word_size : integer := 8;
        reset_to_int_form : integer := 0;
        waiting_time : time := 20 ns
    );
end entity;



architecture behavior of word_tb is

    signal reset_n, enable : std_logic := '0';
    signal data2write : std_logic_vector(word_size - 1 downto 0) := std_logic_vector(to_unsigned(0, word_size));
    signal data2read, data2read_n : std_logic_vector(word_size - 1 downto 0);

begin
 
    UUT: entity work.word 
        generic map( 
            word_size => word_size,
            reset_to_int_form => reset_to_int_form
        )
        port map( 
            enable => enable,
            reset_n => reset_n,
            data2write => data2write,
            data2read => data2read,
            data2read_n => data2read_n
        );

        TEST: process 
        begin

            wait for waiting_time;
            assert data2read = std_logic_vector(to_unsigned(reset_to_int_form, word_size))
                report "The resetting isn't being done as desired. reset_to_int_form = " & integer'image(reset_to_int_form)
                severity error;
            
            reset_n <= '1';
            enable <= '1';

            for i in 2**word_size - 1 downto 0 loop

                data2write <= std_logic_vector(to_unsigned(i, word_size));
                wait for waiting_time;

                assert (data2read = data2write) and (data2read = not data2read_n)
                    report "Problem at value: " & integer'image(i) & " with enable = 1"
                    severity error;

            end loop;
                wait for waiting_time;

            data2write <= std_logic_vector(to_unsigned(1, word_size));
            enable <= '0';
            wait for waiting_time;

            for i in 2**word_size - 1 downto 0 loop

                data2write <= std_logic_vector(to_unsigned(i, word_size));
                wait for waiting_time;

                assert (data2read = std_logic_vector(to_unsigned(0, word_size))) and (data2read = not data2read_n)
                    report "Problem at value: " & integer'image(i) & " with enable = 0"
                    severity error;

            end loop;

            
            
            
        wait;
        end process;

    
    



    

end architecture;