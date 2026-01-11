library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;



entity priority_picker_tb is 
    generic (
        WIDTH : positive := 4;
        SEED1 : positive := 1;
        SEED2 : positive := 2;
        NUM : positive := 10;
        WAITING_TIME : time := 10 ns
    );
end entity;



architecture behavior of priority_picker_tb is

    subtype data_type is std_logic_vector(WIDTH - 1 downto 0);
    -- type real_vector is array(WIDTH - 1 downto 0) of real;

    signal input : data_type;
    signal output : data_type;

begin

    UUT: entity work.priority_picker 
        generic map(
            WIDTH => WIDTH
        )
        port map(
            input => input,
            output => output
        );

    TEST: process 
        -- variable rand_reals : real_vector;
        variable rand_real : real;
        variable seed1_copy : positive := SEED1;
        variable seed2_copy : positive := SEED2;

    begin
        report "Starting the test" severity note;
        for i in 1 to NUM loop
            report integer'image(i) & "th iteration of the loop" severity note;
            uniform(seed1_copy, seed2_copy, rand_real);
            input <= std_logic_vector(to_unsigned(integer(rand_real * real(2**WIDTH - 1)), WIDTH));
            wait for WAITING_TIME;            
        end loop;
        report "Testing done" severity note;
        wait;
    end process;

    

end architecture;